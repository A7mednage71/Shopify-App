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
        context.coordinator.observeURLChanges(in: webView)
        return webView
    }

    func updateUIView(_ webView: WKWebView, context: Context) {
        context.coordinator.onCheckoutCompleted = onCheckoutCompleted
        context.coordinator.loadInitialURL(url, in: webView)
    }

    static func dismantleUIView(_ webView: WKWebView, coordinator: Coordinator) {
        coordinator.stopObservingURLChanges()
    }
}

private final class Coordinator: NSObject, WKNavigationDelegate, WKUIDelegate {
    var onCheckoutCompleted: (URL) -> Void

    private let completionDetector = CheckoutCompletionDetector()
    private var didReportCompletion = false
    private var didLoadInitialURL = false
    private var urlObservation: NSKeyValueObservation?

    init(onCheckoutCompleted: @escaping (URL) -> Void) {
        self.onCheckoutCompleted = onCheckoutCompleted
    }

    func observeURLChanges(in webView: WKWebView) {
        urlObservation = webView.observe(\.url, options: [.new]) { [weak self] _, change in
            guard let url = change.newValue ?? nil else { return }

            self?.reportCompletionIfNeeded(url)
        }
    }

    func loadInitialURL(_ url: URL, in webView: WKWebView) {
        guard !didLoadInitialURL else { return }

        didLoadInitialURL = true
        webView.load(URLRequest(url: url))
    }

    func stopObservingURLChanges() {
        urlObservation?.invalidate()
        urlObservation = nil
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
        evaluateCurrentLocation(in: webView)
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

    private func evaluateCurrentLocation(in webView: WKWebView) {
        webView.evaluateJavaScript("window.location.href") { [weak self] result, _ in
            guard let urlString = result as? String,
                  let url = URL(string: urlString) else {
                return
            }

            self?.reportCompletionIfNeeded(url)
        }
    }
}
