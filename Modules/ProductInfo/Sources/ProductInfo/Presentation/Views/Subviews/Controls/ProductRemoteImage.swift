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
                        placeholder
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                    case .failure:
                        placeholder
                    @unknown default:
                        placeholder
                    }
                }
            } else {
                placeholder
            }
        }
        .accessibilityLabel(altText ?? "Product image")
    }

    private var placeholder: some View {
        ZStack {
            ProductPalette.imageBackground

            Image(systemName: "photo")
                .font(.system(size: 34, weight: .medium))
                .foregroundColor(ProductPalette.textTertiary)
        }
    }
}
