import Common
import SwiftUI

struct CartLoadedView: View {
    let cart: CartDetails
    let errorMessage: String?
    let onIncrement: (String) -> Void
    let onDecrement: (String) -> Void

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 0) {
                if let errorMessage, !errorMessage.isEmpty {
                    CartInlineErrorView(message: errorMessage)
                        .padding(.horizontal, 22)
                        .padding(.bottom, 10)
                }

                VStack(spacing: 0) {
                    ForEach(Array(cart.lines.enumerated()), id: \.element.id) { index, line in
                        CartLineRow(
                            line: line,
                            onIncrement: { onIncrement(line.id) },
                            onDecrement: { onDecrement(line.id) }
                        )

                        if index < cart.lines.count - 1 {
                            Divider()
                                .background(AppColors.border)
                                .padding(.leading, 22)
                        }
                    }
                }
                .padding(.top, 6)

                CartOrderSummaryView(cart: cart)
                    .padding(.horizontal, 22)
                    .padding(.top, 22)

                CartPrimaryButton(title: CartText.checkoutButtonTitle, action: {})
                    .padding(.horizontal, 22)
                    .padding(.top, 18)
                    .padding(.bottom, 26)
            }
        }
    }
}
