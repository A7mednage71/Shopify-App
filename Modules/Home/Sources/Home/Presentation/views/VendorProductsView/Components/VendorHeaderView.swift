import SwiftUI
import Common

struct VendorHeaderView: View {
    let vendorName: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack(spacing: 8) {
                Image(systemName: "tag.fill")
                    .foregroundColor(.appPrimaryOrange)
                    .font(.system(size: 14))
                Text(L10n.Home.officialVendorLabel)
                    .font(.system(size: 12, weight: .bold))
                    .foregroundColor(.appPrimaryOrange)
                    .textCase(.uppercase)
            }
            
            Text(vendorName)
                .font(.system(size: 28, weight: .bold))
                .foregroundColor(.appTextPrimary)
            
            Text(L10n.Home.vendorBrowseDescription(vendorName))
                .font(.system(size: 13))
                .foregroundColor(.appTextSecondary)
        }
        .padding(.horizontal, 16)
        .padding(.top, 16)
        .padding(.bottom, 24)
    }
}
