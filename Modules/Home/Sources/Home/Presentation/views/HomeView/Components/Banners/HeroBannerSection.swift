import SwiftUI
import Common

// MARK: - Hero Banner / Carousel Section
// Shopify API: Requires metafields OR Theme Customizer blocks
// Metafield namespace: custom.hero_banners (JSON list)
// OR hardcode from CMS / Contentful / your backend

// MARK: - Hero Banner / Carousel Section
struct HeroBannerSection: View {
    let banners: [HeroBanner]
    @State private var currentIndex: Int = 0
    @State private var copiedMessage: String? = nil 
    
    private let timer = Timer.publish(every: 3.5, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack(alignment: .top) {
            
            VStack(spacing: 10) {
                // Banner Carousel
                TabView(selection: $currentIndex) {
                    ForEach(Array(banners.enumerated()), id: \.offset) { index, banner in
                        BannerCard(banner: banner) { code in
                            copyToClipboard(code: code)
                        }
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
            
            if let message = copiedMessage {
                Text(message)
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .foregroundColor(.appTextWhite)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 20)
                    .background(Color.black.opacity(0.85))
                    .cornerRadius(25)
                    .transition(.move(edge: .top).combined(with: .opacity))
                    .padding(.top, 10)
                    .zIndex(1)
            }
        }
    }
    
    private func copyToClipboard(code: String) {
        UIPasteboard.general.string = code
        
        withAnimation {
            copiedMessage = "Coupon '\(code)' Copied!"
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            withAnimation {
                copiedMessage = nil
            }
        }
    }
}

// MARK: - Single Banner Card
struct BannerCard: View {
    let banner: HeroBanner
    var onCopy: ((String) -> Void)? 
    
    var body: some View {
        ZStack(alignment: .leading) {
            
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
                    Button(action: {
                        if let code = banner.couponCode {
                            onCopy?(code)
                        } else {
                            print("Navigate to: \(banner.ctaHandle)")
                        }
                    }) {
                        HStack(spacing: 6) {
                            Text(banner.ctaText)
                                .font(.buttonPrimary)
                                .foregroundColor(.appTextWhite)
                            
                            Image(systemName: banner.couponCode != nil ? "doc.on.doc" : "arrow.right")
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
