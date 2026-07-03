import SwiftUI

struct VendorEmptyStateView: View {
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "cart.badge.questionmark")
                .font(.system(size: 50, weight: .light))
                .foregroundColor(.appBorderMedium)
                .padding(.top, 60)
            
            Text("No products found")
                .font(.sectionTitle)
                .foregroundColor(.appTextPrimary)
            
            Text("We couldn't find any products listed under this vendor right now.")
                .font(.offerSubtitle)
                .foregroundColor(.appTextSecondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
        }
        .frame(maxWidth: .infinity)
    }
}
