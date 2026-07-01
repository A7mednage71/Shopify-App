import Foundation

struct CheckoutCompletionDetector {
    func isCompletionURL(_ url: URL) -> Bool {
        let path = url.path.lowercased()

        return path.contains("/checkouts/") && path.contains("/thank-you")
    }
}
