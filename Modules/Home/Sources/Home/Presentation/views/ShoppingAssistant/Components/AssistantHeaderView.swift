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
                    .font(.system(size: 24))
                    .foregroundColor(AppColors.textSecondary)
            }
            .padding(.trailing, 8)

            VStack(alignment: .leading, spacing: 2) {
                Text("Smart Shopping Assistant")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(AppColors.textPrimary)
                
                if isCatalogLoading {
                    Text("Loading products catalog...")
                        .font(.system(size: 10))
                        .foregroundColor(AppColors.textSecondary.opacity(0.7))
                } else if hasCatalogError {
                    Text("Failed to load products")
                        .font(.system(size: 10))
                        .foregroundColor(AppColors.error)
                } else {
                    Text("Active · Shopify Catalog Synced")
                        .font(.system(size: 10))
                        .foregroundColor(AppColors.success)
                }
            }
            
            Spacer()

            Text("AI POWERED")
                .font(.system(size: 10, weight: .bold, design: .monospaced))
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
