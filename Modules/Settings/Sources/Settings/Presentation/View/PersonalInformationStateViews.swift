import Common
import SwiftUI

struct PersonalInformationLoadingView: View {
    var body: some View {
        VStack(spacing: 12) {
            ProgressView()
                .tint(AppColors.primary)

            Text("Loading your profile details")
                .font(AppFonts.callout.weight(.semibold))
                .foregroundColor(AppColors.textSecondary)
        }
        .padding(24)
        .frame(maxWidth: .infinity)
        .background(AppColors.background)
        .cornerRadius(18)
    }
}

struct PersonalInformationFailureView: View {
    let message: String
    let onRetry: () -> Void

    var body: some View {
        VStack(spacing: 14) {
            Text(message)
                .font(AppFonts.callout)
                .foregroundColor(AppColors.textSecondary)
                .multilineTextAlignment(.center)

            Button(action: onRetry) {
                Text("Retry")
                    .font(AppFonts.callout.weight(.bold))
                    .foregroundColor(AppColors.primary)
            }
            .buttonStyle(.plain)
        }
        .padding(20)
        .frame(maxWidth: .infinity)
        .background(AppColors.background)
        .cornerRadius(18)
    }
}
