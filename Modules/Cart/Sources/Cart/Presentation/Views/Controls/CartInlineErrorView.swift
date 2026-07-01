import Common
import SwiftUI

struct CartInlineErrorView: View {
    let message: String

    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: "exclamationmark.circle.fill")
                .font(.system(size: 15, weight: .bold))

            Text(message)
                .font(.system(size: 13, weight: .semibold))
                .lineLimit(2)

            Spacer()
        }
        .foregroundColor(AppColors.textWhite)
        .padding(.horizontal, 14)
        .padding(.vertical, 10)
        .background(AppColors.primary)
        .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
    }
}
