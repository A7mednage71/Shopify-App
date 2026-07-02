import SwiftUI

public struct UnsignedUserPlaceholderView: View {
    
    let onJoinUsTapped: () -> Void
    
    public init(onJoinUsTapped: @escaping () -> Void) {
        self.onJoinUsTapped = onJoinUsTapped
    }
    
    public var body: some View {
        VStack(spacing: 24) {
            Spacer()
            
            
            ZStack {
                Circle()
                    .fill(Color.orange.opacity(0.1))
                    .frame(width: 100, height: 100)
                
                Image(systemName: "person.crop.circle.badge.plus")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .foregroundColor(.orange)
            }
            
            VStack(spacing: 8) {
                Text("You're not signed in")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                
                Text("Join us to unlock all features and personalize your experience.")
                    .font(.subheadline)
                    .foregroundColor(AppColors.textPrimary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 32)
            }
            
            Button(action: onJoinUsTapped) {
                Text("Join us now")
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
}


struct UnsignedUserPlaceholderView_Previews: PreviewProvider {
    static var previews: some View {
        UnsignedUserPlaceholderView(onJoinUsTapped: {
            print("Navigate to auth flow")
        })
    }
}
