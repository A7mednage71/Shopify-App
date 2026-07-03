import SwiftUI
import Common

// MARK: - Hero Banner / Carousel Section
// Shopify API: Requires metafields OR Theme Customizer blocks
// Metafield namespace: custom.hero_banners (JSON list)
// OR hardcode from CMS / Contentful / your backend

struct HeroBannerSection: View {
    let banners: [HeroBanner]
    @State private var currentIndex: Int = 0
    
    private let timer = Timer.publish(every: 3.5, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack(spacing: 10) {
            
            // Banner Carousel
            TabView(selection: $currentIndex) {
                ForEach(Array(banners.enumerated()), id: \.offset) { index, banner in
                    BannerCard(banner: banner)
                        .tag(index)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .frame(height: 170)
            .padding(.horizontal, 16)
            .onReceive(timer) { _ in
                withAnimation(.easeInOut(duration: 0.5)) {
                    currentIndex = (currentIndex + 1) % banners.count
                }
            }
            
            // Page Dots
            HStack(spacing: 6) {
                ForEach(0..<banners.count, id: \.self) { index in
                    Circle()
                        .fill(index == currentIndex ? Color.appPrimaryOrange : Color.appBorderMedium)
                        .frame(width: index == currentIndex ? 10 : 6,
                               height: index == currentIndex ? 10 : 6)
                        .animation(.easeInOut(duration: 0.2), value: currentIndex)
                }
            }
        }
    }
}

// MARK: - Single Banner Card
struct BannerCard: View {
    let banner: HeroBanner
    
    var body: some View {
        ZStack(alignment: .leading) {
            
            // Gradient Background
            LinearGradient(
                colors: banner.gradientColors,
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .cornerRadius(16)
            
            // Content
            HStack(alignment: .center) {
                
                // Text Side
                VStack(alignment: .leading, spacing: 8) {
                    Text(banner.title)
                        .font(.heroTitle)
                        .foregroundColor(.appTextWhite)
                        .lineLimit(2)
                    
                    Text(banner.subtitle)
                        .font(.heroSubtitle)
                        .foregroundColor(.appTextWhite.opacity(0.9))
                        .lineLimit(3)
                    
                    // CTA Button
                    Button(action: {}) {
                        HStack(spacing: 6) {
                            Text(banner.ctaText)
                                .font(.buttonPrimary)
                                .foregroundColor(.appTextWhite)
                            Image(systemName: "arrow.right")
                                .font(.dealButtonIcon)
                                .foregroundColor(.appTextWhite)
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.appTextWhite, lineWidth: 1.5)
                        )
                    }
                    .padding(.top, 4)
                }
                .padding(.leading, 20)
                .frame(maxWidth: .infinity, alignment: .leading)
                
                // Product Image
                AsyncImage(url: URL(string: banner.imageURL)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    Color.appWhiteOverlayLight
                }
                .frame(width: 130, height: 150)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .clipped()
                .padding(.trailing, 10)
            }
        }
        .frame(height: 170)
        .clipped()
    }
}

// MARK: - Preview
#Preview {
    HeroBannerSection(banners: MockShopifyData.heroBanners)
        .padding(.vertical)
}
