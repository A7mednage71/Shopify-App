import Common
import SwiftUI

struct CartHeaderView: View {
    let count: Int
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            
            HStack(alignment: .firstTextBaseline, spacing: 8) {
                Text(CartText.navigationTitle)
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(AppColors.textPrimary)
                
                if count > 0 {
                    Text("(\(count))")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(AppColors.textSecondary)
                }
            }
            
            Text(CartText.itemsSummaryTitle)
                .font(.system(size: 13))
                .foregroundColor(AppColors.textSecondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 22)
        .padding(.top, 16)
        .padding(.bottom, 16)
    }
}
