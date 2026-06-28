import SwiftUI

struct ProductInfoHeroSection: View {
    let imageURL: String?
    let altText: String?
    let height: CGFloat

    var body: some View {
        ProductRemoteImage(urlString: imageURL, altText: altText)
            .frame(maxWidth: .infinity)
            .frame(height: height)
            .clipped()
            .ignoresSafeArea(.container, edges: .top)
    }
}
