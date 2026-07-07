import SwiftUI
import Common

struct ProductRemoteImage: View {
    let urlString: String?
    let altText: String?

    var body: some View {
        CachedImage(urlString: urlString, failureImageName: "product_placeholder")
            .accessibilityLabel(altText ?? ProductInfoText.productImageAccessibilityLabel)
    }
}
