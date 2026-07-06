import SwiftUI
import Common

struct AssistantErrorBubbleView: View {
    let error: String
    let onResend: () -> Void

    var body: some View {
        HStack(spacing: 8) {
            Text(error)
                .font(.system(size: 13))
                .foregroundColor(.white)
            
            Button(action: onResend) {
                Text("Resend")
                    .font(.system(size: 11, weight: .bold))
                    .foregroundColor(AppColors.textWhite)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color.white.opacity(0.2))
                    .cornerRadius(4)
            }
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .background(AppColors.error)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .frame(maxWidth: .infinity, alignment: .trailing)
    }
}
