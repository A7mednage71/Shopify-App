import SwiftUI
import Common

struct AssistantCatalogErrorView: View {
    let error: String
    let onRetry: () -> Void

    var body: some View {
        VStack(spacing: 16) {
            Spacer()
            Image(systemName: "exclamationmark.triangle.fill")
                .font(.system(size: 44))
                .foregroundColor(AppColors.error)
            Text(error)
                .font(.assistantBubble)
                .multilineTextAlignment(.center)
                .foregroundColor(AppColors.textPrimary)
                .padding(.horizontal, 24)
            
            Button(action: onRetry) {
                Text(L10n.Home.assistantRetry)
                    .font(.buttonPrimary)
                    .foregroundColor(.white)
                    .padding(.horizontal, 24)
                    .padding(.vertical, 10)
                    .background(AppColors.primary)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            }
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .background(AppColors.backgroundSecondary)
    }
}
