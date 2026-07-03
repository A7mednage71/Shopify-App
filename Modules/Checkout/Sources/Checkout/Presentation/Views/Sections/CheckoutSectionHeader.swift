import Common
import SwiftUI

struct CheckoutSectionHeader: View {
    let title: String

    var body: some View {
        Text(title)
            .font(.system(size: 21, weight: .bold))
            .foregroundColor(AppColors.textPrimary)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}
