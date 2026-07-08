import SwiftUI
import Common

struct AssistantHeaderView: View {
    let isCatalogLoading: Bool
    let hasCatalogError: Bool
    let onDismiss: () -> Void

    var body: some View {
        HStack {
            Button(action: onDismiss) {
                Image(systemName: "xmark.circle.fill")
                    .font(.assistantHeaderIcon)
                    .foregroundColor(AppColors.textSecondary)
            }
            .padding(.trailing, 8)

            VStack(alignment: .leading, spacing: 2) {
                Text(L10n.Home.assistantTitle)
                    .font(.assistantTitle)
                    .foregroundColor(AppColors.textPrimary)
                
                if isCatalogLoading {
                    Text(L10n.Home.assistantLoading)
                        .font(.assistantSubtitle)
                        .foregroundColor(AppColors.textSecondary.opacity(0.7))
                } else if hasCatalogError {
                    Text(L10n.Home.assistantFailedToLoad)
                        .font(.assistantSubtitle)
                        .foregroundColor(AppColors.error)
                } else {
                    Text(L10n.Home.assistantActive)
                        .font(.assistantSubtitle)
                        .foregroundColor(AppColors.success)
                }
            }
            
            Spacer()

            Text(L10n.Home.assistantAIPowered)
                .font(.assistantHeaderBadge)
                .foregroundColor(AppColors.primary)
                .padding(.horizontal, 8)
                .padding(.vertical, 3)
                .overlay(
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(AppColors.primary, lineWidth: 1.5)
                )
                .background(AppColors.primary.opacity(0.08))
                .cornerRadius(4)
        }
        .padding(16)
        .background(AppColors.background)
        .overlay(Rectangle().fill(AppColors.border).frame(height: 1), alignment: .bottom)
    }
}
