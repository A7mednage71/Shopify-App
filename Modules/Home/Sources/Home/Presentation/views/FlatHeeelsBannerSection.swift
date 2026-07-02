import SwiftUI
import Common

// MARK: - Flat and Heels Banner Section

struct FlatHeeelsBannerSection: View {
    let product: SearchProduct
    var onVisitTap: (() -> Void)? = nil
    
    var body: some View {
        ZStack(alignment: .trailing) {
            
            // Background gradient
            LinearGradient(
                colors: [Color.appPrimaryOrange.opacity(0.10), Color.appPrimaryOrange.opacity(0.04)],
                startPoint: .leading,
                endPoint: .trailing
            )
            .cornerRadius(14)
            
            HStack(spacing: 0) {
                // Product Image
                AsyncImage(url: URL(string: product.featuredImageURL!)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    Image(systemName: "shoeprints.fill")
                        .font(.system(size: 42))
                        .foregroundColor(.appPrimaryOrange.opacity(0.35))
                        .frame(width: 110, height: 100)
                }
                .frame(width: 110, height: 100)
                .clipped()
                .cornerRadius(10)
                .padding(.leading, 14)
                .padding(.vertical, 14)
                
                Spacer()
                
                // Text + CTA
                VStack(alignment: .leading, spacing: 6) {
                    Text(HomeStrings.FlatHeels.title)
                        .font(.bannerTitle)
                        .foregroundColor(.appTextPrimary)
                    
                    Text(HomeStrings.FlatHeels.subtitle)
                        .font(.bannerSubtitle)
                        .foregroundColor(.appTextSecondary)
                        .multilineTextAlignment(.trailing)
                        .lineLimit(2)
                    
                    // Visit Now CTA
                    Button(action: { onVisitTap?() }) {
                        HStack(spacing: 4) {
                            Text(HomeStrings.FlatHeels.cta)
                                .font(.buttonSmall)
                                .foregroundColor(.appTextWhite)
                            Image(systemName: "arrow.right")
                                .font(.dealButtonIcon)
                                .foregroundColor(.appTextWhite)
                        }
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(Color.appPrimaryOrange)
                        .clipShape(Capsule())
                    }
                    .buttonStyle(.plain)
                }
                .padding(.trailing, 16)
                .padding(.vertical, 14)
            }
        }
        .frame(height: 128)
        .cornerRadius(14)
        .overlay(
            RoundedRectangle(cornerRadius: 14)
                .stroke(Color.appPrimaryOrange.opacity(0.15), lineWidth: 1)
        )
        .padding(.horizontal, 16)
    }
}

// MARK: - Preview
#Preview {
    FlatHeeelsBannerSection(product: MockShopifyData.featuredProducts[2])
        .padding(.vertical)
}
