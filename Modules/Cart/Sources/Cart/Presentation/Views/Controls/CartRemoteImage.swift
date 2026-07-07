import Common
import SwiftUI

struct CartRemoteImage: View {
    let urlString: String?
    let altText: String?

    var body: some View {
        CachedImage(urlString: urlString, failureImageName: "product_placeholder")
            .accessibilityLabel(altText ?? CartText.cartItemImageAccessibilityLabel)
    }
}
