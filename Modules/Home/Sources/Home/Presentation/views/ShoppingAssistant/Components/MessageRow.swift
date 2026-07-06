import SwiftUI
import Common

struct MessageRow: View {
    let message: ChatMessage
    let products: [ShopProduct]

    init(message: ChatMessage, products: [ShopProduct]) {
        self.message = message
        self.products = products
    }

    public var body: some View {
        HStack(alignment: .top, spacing: 10) {
            if message.role == .assistant {
                // AI Sparkle Avatar
                Image(systemName: "sparkles")
                    .font(.system(size: 12, weight: .bold))
                    .foregroundColor(.white)
                    .padding(8)
                    .background(AppColors.primary)
                    .clipShape(Circle())
                    .shadow(color: AppColors.primary.opacity(0.2), radius: 4, x: 0, y: 2)
            } else {
                Spacer(minLength: 50)
            }

            VStack(alignment: message.role == .user ? .trailing : .leading, spacing: 8) {
                Text(message.text)
                    .font(.system(size: 14.5, weight: .medium))
                    .padding(.horizontal, 14)
                    .padding(.vertical, 10)
                    .background(message.role == .user ? AppColors.primary : AppColors.background)
                    .foregroundColor(message.role == .user ? AppColors.textWhite : AppColors.textPrimary)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .shadow(color: Color.black.opacity(0.04), radius: 3, x: 0, y: 1.5)
                    .frame(maxWidth: 280, alignment: message.role == .user ? .trailing : .leading)

                if !products.isEmpty {
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                        ForEach(products) { product in
                            ProductCardView(product: product)
                        }
                    }
                    .padding(.top, 4)
                    .frame(maxWidth: 290)
                }
            }

            if message.role == .user {
                // Spacer to push user message to the right
            } else {
                Spacer(minLength: 50)
            }
        }
        .frame(maxWidth: .infinity, alignment: message.role == .user ? .trailing : .leading)
    }
}
