import Common
import SwiftUI

struct CartPriceView: View {
    let money: CartMoney?

    var body: some View {
        PriceView(
            priceInUSD: money?.priceViewValue ?? 0,
            font: .system(size: 21, weight: .heavy),
            color: AppColors.textPrimary
        )
            .font(.system(size: 21, weight: .heavy))
            .foregroundColor(AppColors.textPrimary)
            .monospacedDigit()
            .minimumScaleFactor(0.72)
            .lineLimit(1)
            .layoutPriority(1)
    }
}
