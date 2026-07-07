import Common
import SwiftUI

struct CheckoutRemoteImage: View {
    let urlString: String?
    let altText: String?

    var body: some View {
        CachedImage(urlString: urlString, failureImageName: "product_placeholder")
            .accessibilityLabel(altText ?? CheckoutText.cartItemImageAccessibilityLabel)
    }
}
