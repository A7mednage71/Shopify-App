import SwiftUI
import Common

// MARK: - Trending Products Section

struct TrendingProductsSection: View {
    let products: [HomeProduct]
    var onProductTap: ((HomeProduct) -> Void)? = nil
    
    var body: some View {

        VStack(alignment: .leading, spacing: 0) {
            
            VStack(alignment: .leading, spacing: 4) {
                Text(HomeStrings.Trending.sectionTitle)
                    .font(.sectionTitle)
                    .foregroundColor(.appTextWhite)
                
                HStack(spacing: 5) {
                    Image(systemName: "calendar")
                        .font(.system(size: 11))
                    Text(HomeStrings.Trending.lastDate)
                        .font(.system(size: 11, weight: .regular))
                }
                .foregroundColor(.appTextWhite.opacity(0.9))
            }
            .padding(.horizontal, 16)
            .padding(.top, 16)
            .padding(.bottom, 12)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(Array(products.enumerated()), id: \.element.id) { index, product in
                        TrendingProductCard(product: product, index: index)
                            .padding(.vertical, 4)
                            .onTapGesture {
                                onProductTap?(product)
                            }
                    }
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 16)
            }
        }
        .background(Color.appPrimaryOrange)
        .cornerRadius(14)
        .padding(.horizontal, 16)
    }
}
