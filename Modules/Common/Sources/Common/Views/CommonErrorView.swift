import SwiftUI

public struct CommonErrorView: View {
    public let message: String
    public let onRetry: () -> Void

    public init(message: String, onRetry: @escaping () -> Void) {
        self.message = message
        self.onRetry = onRetry
    }

    public var body: some View {
        VStack(spacing: 24) {
            // Icon container
            ZStack {
                Circle()
                    .fill(Color.appPrimaryOrange.opacity(0.1))
                    .frame(width: 80, height: 80)
                
                Image(systemName: "exclamationmark.triangle.fill")
                    .font(.system(size: 36))
                    .foregroundColor(.appPrimaryOrange)
            }
            .padding(.top, 24)

            // Text content
            VStack(spacing: 8) {
                Text("Something went wrong")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.appTextPrimary)
                
                Text(message)
                    .font(.system(size: 14))
                    .foregroundColor(.appTextSecondary)
                    .multilineTextAlignment(.center)
                    .lineSpacing(4)
                    .padding(.horizontal, 32)
            }

            // Retry Button
            Button(action: onRetry) {
                HStack(spacing: 8) {
                    Image(systemName: "arrow.clockwise")
                        .font(.system(size: 14, weight: .bold))
                    Text("Try Again")
                        .font(.buttonPrimary)
                }
                .foregroundColor(.white)
                .padding(.horizontal, 28)
                .padding(.vertical, 14)
                .background(
                    Capsule()
                        .fill(Color.appPrimaryOrange)
                        .shadow(color: Color.appPrimaryOrange.opacity(0.3), radius: 8, x: 0, y: 4)
                )
            }
            .padding(.bottom, 24)
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 20)
        .padding(.vertical, 40)
    }
}

struct CommonErrorView_Previews: PreviewProvider {
    static var previews: some View {
        CommonErrorView(message: "Failed to load collections due to a network connection timeout. Please check your connection and try again.") {
            print("Retry tapped")
        }
        .background(Color.appBackgroundGray)
    }
}
