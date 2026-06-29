import SwiftUI

// MARK: - Special Offers Section
// Shopify API: Collection tagged "special-offers" OR metafield badge on products
// Products with compare_at_price set automatically qualify as "on sale"

struct SpecialOffersSection: View {
    var onTap: (() -> Void)? = nil
    
    var body: some View {
        Button(action: { onTap?() }) {
            HStack(spacing: 14) {
                
                // Offer Icon / Badge (replace with your asset)
                ZStack {
                    Circle()
                        .fill(
                            LinearGradient(
                                colors: [Color.primaryOrange, Color.primaryPink],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(width: 56, height: 56)
                    
                    Text("🎁")
                        .font(.system(size: 26))
                }
                
                // Text Content
                VStack(alignment: .leading, spacing: 4) {
                    HStack(spacing: 6) {
                        Text("Special Offers")
                            .font(.offerTitle)
                            .foregroundColor(.textPrimary)
                        
                        // Discount emoji badge
                        Text("😍")
                            .font(.system(size: 16))
                    }
                    
                    Text("We make sure you get the offer you need at best prices")
                        .font(.offerSubtitle)
                        .foregroundColor(.textSecondary)
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)
                }
                
                Spacer()
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 14)
            .background(Color.backgroundWhite)
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Flat and Heels Banner Section
// Shopify API: Specific collection "flat-and-heels" with custom banner metafield
// OR: CMS-managed banner content

struct FlatHeeelsBannerSection: View {
    let product: ShopifyProduct
    var onVisitTap: (() -> Void)? = nil
    
    var body: some View {
        ZStack(alignment: .trailing) {
            
            // Yellow/Gold background pattern
            Rectangle()
                .fill(
                    LinearGradient(
                        colors: [Color.primaryOrange.opacity(0.12), Color.primaryOrange.opacity(0.05)],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .overlay(
                    // Polka dot / pattern overlay (optional — add your texture here)
                    Color.primaryOrange.opacity(0.04)
                )
            
            HStack {
                // Product Image (shoes)
                AsyncImage(url: URL(string: product.featuredImageURL)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                } placeholder: {
                    Image(systemName: "shoeprints.fill")
                        .font(.system(size: 50))
                        .foregroundColor(.primaryOrange.opacity(0.3))
                }
                .frame(width: 130, height: 110)
                .padding(.leading, 16)
                
                Spacer()
                
                // Text + CTA
                VStack(alignment: .trailing, spacing: 8) {
                    Text("Flat and Heels")
                        .font(.bannerTitle)
                        .foregroundColor(.textPrimary)
                    
                    Text("Stand a chance to get rewarded")
                        .font(.bannerSubtitle)
                        .foregroundColor(.textSecondary)
                        .multilineTextAlignment(.trailing)
                        .lineLimit(2)
                    
                    Button(action: { onVisitTap?() }) {
                        HStack(spacing: 4) {
                            Text("Visit now")
                                .font(.buttonSmall)
                                .foregroundColor(.primaryOrange)
                            Image(systemName: "arrow.right")
                                .font(.system(size: 11))
                                .foregroundColor(.primaryOrange)
                        }
                    }
                }
                .padding(.trailing, 20)
            }
        }
        .frame(height: 120)
        .cornerRadius(12)
        .padding(.horizontal, 16)
    }
}

// MARK: - Preview
#Preview {
    VStack(spacing: 20) {
        SpecialOffersSection()
        FlatHeeelsBannerSection(product: MockShopifyData.featuredProducts[2])
    }
    .padding(.vertical)
}
