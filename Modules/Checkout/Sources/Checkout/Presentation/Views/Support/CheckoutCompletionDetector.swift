import Foundation

struct CheckoutCompletionDetector {
    func isCompletionURL(_ url: URL) -> Bool {
        let urlText = (url.absoluteString.removingPercentEncoding ?? url.absoluteString).lowercased()
        let path = url.path.lowercased()

        let isCheckoutRoute = path.contains("/checkouts/") || urlText.contains("/checkouts/")
        let isThankYouRoute = path.contains("/thank-you") ||
            path.contains("/thank_you") ||
            urlText.contains("/thank-you") ||
            urlText.contains("/thank_you")

        return isCheckoutRoute && isThankYouRoute
    }
}
