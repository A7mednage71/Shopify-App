import Common
import SwiftUI

struct CartQuantityButton: View {
    let systemName: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: systemName)
                .font(.system(size: 13, weight: .heavy))
                .foregroundColor(AppColors.textPrimary)
                .frame(width: 28, height: 28)
                .background(AppColors.background)
                .clipShape(Circle())
        }
        .buttonStyle(.plain)
    }
}
