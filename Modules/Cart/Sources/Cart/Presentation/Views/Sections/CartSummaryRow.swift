import Common
import SwiftUI

struct CartSummaryRow: View {
    let title: String
    let value: String
    var isTotal = false

    var body: some View {
        HStack {
            Text(title)
                .font(.system(size: isTotal ? 17 : 16, weight: isTotal ? .bold : .semibold))
                .foregroundColor(isTotal ? AppColors.textPrimary : AppColors.textSecondary)

            Spacer()

            Text(value)
                .font(.system(size: isTotal ? 17 : 16, weight: .bold))
                .foregroundColor(isTotal ? AppColors.textPrimary : AppColors.textSecondary)
                .monospacedDigit()
        }
    }
}
