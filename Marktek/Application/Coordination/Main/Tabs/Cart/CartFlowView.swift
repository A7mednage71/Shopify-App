import Cart
import SwiftUI

struct CartFlowView: View {
    let onCheckoutTap: () -> Void
    let onStartShoppingTap: () -> Void
    let onProductTap: (String) -> Void

    var body: some View {
        CartViewFactory.makeView(
            onCheckoutTap: onCheckoutTap,
            onStartShoppingTap: onStartShoppingTap,
            onProductTap: onProductTap
        )
    }
}
