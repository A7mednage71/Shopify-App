import Common
import SwiftUI

struct ProfileInfoRow: View {
    let icon: String
    let title: String
    let value: String

    var body: some View {
        HStack(spacing: 14) {
            Image(systemName: icon)
                .font(.system(size: 15, weight: .semibold))
                .foregroundColor(AppColors.primary)
                .frame(width: 24)

            Text(title)
                .font(AppFonts.callout)
                .foregroundColor(AppColors.textSecondary)

            Spacer(minLength: 12)

            Text(value)
                .font(AppFonts.callout.weight(.semibold))
                .foregroundColor(AppColors.textPrimary)
                .multilineTextAlignment(.trailing)
        }
        .padding(.vertical, 14)
    }
}
