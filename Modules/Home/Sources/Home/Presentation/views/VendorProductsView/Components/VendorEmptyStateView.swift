import SwiftUI

struct VendorEmptyStateView: View {
    var body: some View {
        VStack(spacing: 16) {
            Image("no_products")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 120, height: 120)
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
