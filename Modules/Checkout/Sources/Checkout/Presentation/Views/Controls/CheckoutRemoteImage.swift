import Common
import SwiftUI

struct CheckoutRemoteImage: View {
    let urlString: String?
    let altText: String?

    var body: some View {
        Group {
            if let urlString, let url = URL(string: urlString) {
                AsyncImage(url: url, transaction: Transaction(animation: .easeInOut(duration: 0.2))) { phase in
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
        .accessibilityLabel(altText ?? CheckoutText.cartItemImageAccessibilityLabel)
    }

    private var placeholder: some View {
        ZStack {
            AppColors.backgroundSecondary

            Image(systemName: "photo")
                .font(.system(size: 24, weight: .semibold))
                .foregroundColor(AppColors.textTertiary)
        }
    }
}
