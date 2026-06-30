import Common
import SwiftUI

struct CartQuantityButton: View {
    let systemName: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: systemName)
                .font(.system(size: 15, weight: .heavy))
                .foregroundColor(AppColors.textPrimary)
                .frame(width: 34, height: 34)
                .background(AppColors.background)
                .clipShape(Circle())
        }
        .buttonStyle(.plain)
    }
}
