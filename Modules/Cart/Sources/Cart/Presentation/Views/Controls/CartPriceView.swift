import Common
import SwiftUI

struct CartPriceView: View {
    let money: CartMoney?

    var body: some View {
        HStack(alignment: .firstTextBaseline, spacing: 5) {
            Text(money?.currencySymbol ?? "$")
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(AppColors.textPrimary)

            Text(money?.decimalText(fractionDigits: 2) ?? "0.00")
                .font(.system(size: 30, weight: .heavy))
                .foregroundColor(AppColors.textPrimary)
                .minimumScaleFactor(0.72)
                .lineLimit(1)
        }
    }
}
