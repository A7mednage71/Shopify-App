import SwiftUI
import Common

struct VendorEmptyStateView: View {
    var body: some View {
        VStack(spacing: 16) {
            Image("no_products")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 120, height: 120)
                .padding(.top, 60)
            
            Text(L10n.Home.noProductsFound)
                .font(.sectionTitle)
                .foregroundColor(.appTextPrimary)
            
            Text(L10n.Home.vendorEmptyDescription)
                .font(.offerSubtitle)
                .foregroundColor(.appTextSecondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
        }
        .frame(maxWidth: .infinity)
    }
}
