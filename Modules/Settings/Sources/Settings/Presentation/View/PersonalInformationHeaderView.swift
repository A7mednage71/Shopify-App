import Common
import SwiftUI

struct PersonalInformationHeaderView: View {
    var body: some View {
        VStack(spacing: 12) {
            ZStack {
                Circle()
                    .fill(AppColors.primary.opacity(0.12))
                    .frame(width: 74, height: 74)

                Image(systemName: "person.text.rectangle")
                    .font(.system(size: 32, weight: .semibold))
                    .foregroundColor(AppColors.primary)
            }

            Text(L10n.Settings.profileInformationTitle)
                .font(AppFonts.title2.weight(.bold))
                .foregroundColor(AppColors.textPrimary)

            Text(L10n.Settings.profileSubtitle)
                .font(AppFonts.callout)
                .foregroundColor(AppColors.textSecondary)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
    }
}
