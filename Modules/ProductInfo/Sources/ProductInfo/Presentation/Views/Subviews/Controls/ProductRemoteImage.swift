import SwiftUI

struct ProductRemoteImage: View {
    let urlString: String?
    let altText: String?

    var body: some View {
        Group {
            if let urlString, let url = URL(string: urlString) {
                AsyncImage(url: url, transaction: Transaction(animation: .easeInOut(duration: 0.24))) { phase in
                    switch phase {
                    case .empty:
                        ProductImagePlaceholder()
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                    case .failure:
                        ProductImagePlaceholder()
                    @unknown default:
                        ProductImagePlaceholder()
                    }
                }
            } else {
                ProductImagePlaceholder()
            }
        }
        .accessibilityLabel(altText ?? ProductInfoText.productImageAccessibilityLabel)
    }
}
