import SwiftUI
import Common

struct AssistantCatalogLoadingView: View {
    var body: some View {
        VStack(spacing: 12) {
            Spacer()
            ProgressView()
                .tint(AppColors.primary)
                .scaleEffect(1.2)
            Text(L10n.Home.assistantSyncingCatalog)
                .font(.assistantBubble)
                .foregroundColor(AppColors.textPrimary.opacity(0.8))
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .background(AppColors.backgroundSecondary)
    }
}
