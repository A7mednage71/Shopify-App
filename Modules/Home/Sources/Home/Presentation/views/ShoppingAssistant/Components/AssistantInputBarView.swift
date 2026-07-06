import SwiftUI
import Common

struct AssistantInputBarView: View {
    @Binding var text: String
    let isLoading: Bool
    let isCatalogLoading: Bool
    let onSend: () -> Void

    var body: some View {
        HStack(spacing: 12) {
            TextField("Type your message... e.g. Black Nike size 42", text: $text)
                .padding(12)
                .background(AppColors.backgroundSecondary)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(AppColors.border, lineWidth: 1)
                )
                .disabled(isCatalogLoading)

            Button(action: onSend) {
                Image(systemName: "paperplane.fill")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.white)
                    .padding(12)
                    .background(
                        text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || isLoading || isCatalogLoading
                        ? AppColors.disabled
                        : AppColors.primary
                    )
                    .clipShape(Circle())
            }
            .disabled(isLoading || text.trimmingCharacters(in: .whitespaces).isEmpty || isCatalogLoading)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(AppColors.background)
        .overlay(Rectangle().fill(AppColors.border).frame(height: 1), alignment: .top)
    }
}
