import SwiftUI
import WebKit

struct CheckoutWebView: View {
    let url: URL
    let onCheckoutCompleted: (URL) -> Void

    var body: some View {
        PlatformCheckoutWebView(
            url: url,
            onCheckoutCompleted: onCheckoutCompleted
        )
            .ignoresSafeArea()
    }
}

private struct PlatformCheckoutWebView: UIViewRepresentable {
    let url: URL
    let onCheckoutCompleted: (URL) -> Void

    func makeCoordinator() -> Coordinator {
        Coordinator(onCheckoutCompleted: onCheckoutCompleted)
    }

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        webView.uiDelegate = context.coordinator
        return webView
    }

    func updateUIView(_ webView: WKWebView, context: Context) {
        context.coordinator.onCheckoutCompleted = onCheckoutCompleted

        guard webView.url != url else { return }

        webView.load(URLRequest(url: url))
    }
}

private final class Coordinator: NSObject, WKNavigationDelegate, WKUIDelegate {
    var onCheckoutCompleted: (URL) -> Void

    private let completionDetector = CheckoutCompletionDetector()
    private var didReportCompletion = false

    init(onCheckoutCompleted: @escaping (URL) -> Void) {
        self.onCheckoutCompleted = onCheckoutCompleted
    }

    func webView(
        _ webView: WKWebView,
        decidePolicyFor navigationAction: WKNavigationAction,
        decisionHandler: @escaping (WKNavigationActionPolicy) -> Void
    ) {
        if let url = navigationAction.request.url {
            reportCompletionIfNeeded(url)
        }

        decisionHandler(.allow)
    }

    func webView(
        _ webView: WKWebView,
        decidePolicyFor navigationResponse: WKNavigationResponse,
        decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void
    ) {
        if let url = navigationResponse.response.url {
            reportCompletionIfNeeded(url)
        }

        decisionHandler(.allow)
    }

    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        guard let url = webView.url else { return }

        reportCompletionIfNeeded(url)
    }

    func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        guard let url = webView.url else { return }

        reportCompletionIfNeeded(url)
    }

    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        guard let url = webView.url else { return }

        reportCompletionIfNeeded(url)
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        guard let url = webView.url else { return }

        reportCompletionIfNeeded(url)
    }

    func webView(
        _ webView: WKWebView,
        createWebViewWith configuration: WKWebViewConfiguration,
        for navigationAction: WKNavigationAction,
        windowFeatures: WKWindowFeatures
    ) -> WKWebView? {
        guard navigationAction.targetFrame == nil,
              let url = navigationAction.request.url else {
            return nil
        }

        reportCompletionIfNeeded(url)
        webView.load(URLRequest(url: url))

        return nil
    }

    private func reportCompletionIfNeeded(_ url: URL) {
        guard !didReportCompletion,
              completionDetector.isCompletionURL(url) else {
            return
        }

        didReportCompletion = true

        DispatchQueue.main.async { [onCheckoutCompleted] in
            onCheckoutCompleted(url)
        }
    }
}
