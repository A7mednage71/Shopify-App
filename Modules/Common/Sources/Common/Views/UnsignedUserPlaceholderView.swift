import SwiftUI

public struct UnsignedUserPlaceholderView: View {
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @State private var illustrationScale: CGFloat = 0.98

    private let title: String
    private let message: String
    private let buttonTitle: String
    let onJoinUsTapped: () -> Void
    
    public init(
        title: String = "You're not signed in",
        message: String = "Join us to unlock all features and personalize your experience.",
        buttonTitle: String = "Join us now",
        onJoinUsTapped: @escaping () -> Void
    ) {
        self.title = title
        self.message = message
        self.buttonTitle = buttonTitle
        self.onJoinUsTapped = onJoinUsTapped
    }
    
    public var body: some View {
        VStack(spacing: 24) {
            Spacer()

            Image("UnauthenticatedPlaceholder", bundle: .module)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 240)
                .padding(.horizontal, 24)
                .scaleEffect(illustrationScale)
                .onAppear {
                    startIllustrationAnimation()
                }
                .onChange(of: reduceMotion) { _ in
                    startIllustrationAnimation()
                }
            
            VStack(spacing: 8) {
                Text(title)
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                
                Text(message)
                    .font(.subheadline)
                    .foregroundColor(AppColors.textPrimary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 32)
            }
            
            Button(action: onJoinUsTapped) {
                Text(buttonTitle)
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(AppColors.primary)
                    .cornerRadius(12)
            }
            .padding(.horizontal, 24)
            .padding(.top, 8)
            
            Spacer()
        }
        .padding()
    }

    private func startIllustrationAnimation() {
        guard !reduceMotion else {
            illustrationScale = 1.0
            return
        }

        illustrationScale = 0.98
        withAnimation(.easeInOut(duration: 1.6).repeatForever(autoreverses: true)) {
            illustrationScale = 1.03
        }
    }
}


struct UnsignedUserPlaceholderView_Previews: PreviewProvider {
    static var previews: some View {
        UnsignedUserPlaceholderView(onJoinUsTapped: {
            print("Navigate to auth flow")
        })
    }
}
