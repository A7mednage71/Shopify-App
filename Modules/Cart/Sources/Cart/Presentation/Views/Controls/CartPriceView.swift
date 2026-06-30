import Common
import SwiftUI

struct CartPriceView: View {
    let money: CartMoney?

    var body: some View {
        Text(money?.formattedCurrency(fractionDigits: 0) ?? CartText.priceFallbackText)
            .font(.system(size: 21, weight: .heavy))
            .foregroundColor(AppColors.textPrimary)
            .monospacedDigit()
            .minimumScaleFactor(0.72)
            .lineLimit(1)
            .layoutPriority(1)
    }
}
