import Common
import SwiftUI

struct ProfileInfoSection<Content: View>: View {
    let title: String
    let content: Content

    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title.uppercased())
                .font(AppFonts.footnote.weight(.bold))
                .foregroundColor(AppColors.textSecondary)
                .padding(.horizontal, 4)

            VStack(spacing: 0) {
                content
            }
            .padding(.horizontal, 16)
            .background(AppColors.background)
            .cornerRadius(18)
            .shadow(color: AppColors.shadow.opacity(0.18), radius: 5, x: 0, y: 2)
        }
    }
}
