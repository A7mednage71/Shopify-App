import SwiftUI
import WebKit

struct CheckoutWebView: View {
    let url: URL

    var body: some View {
        PlatformCheckoutWebView(url: url)
            .ignoresSafeArea()
    }
}

#if os(iOS)
private struct PlatformCheckoutWebView: UIViewRepresentable {
    let url: URL

    func makeUIView(context: Context) -> WKWebView {
        WKWebView()
    }

    func updateUIView(_ webView: WKWebView, context: Context) {
        guard webView.url != url else { return }

        webView.load(URLRequest(url: url))
    }
}
#elseif os(macOS)
private struct PlatformCheckoutWebView: NSViewRepresentable {
    let url: URL

    func makeNSView(context: Context) -> WKWebView {
        WKWebView()
    }

    func updateNSView(_ webView: WKWebView, context: Context) {
        guard webView.url != url else { return }

        webView.load(URLRequest(url: url))
    }
}
#endif
