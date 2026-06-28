import SwiftUI

struct ProductThumbnailCarousel: View {
    let galleryImages: [ProductGalleryImage]
    let displayedImageURL: String?
    let productTitle: String
    let onImageSelect: (String) -> Void

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(galleryImages) { image in
                    Button {
                        onImageSelect(image.url)
                    } label: {
                        ProductRemoteImage(urlString: image.url, altText: image.altText ?? productTitle)
                            .frame(width: 68, height: 68)
                            .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
                            .overlay {
                                RoundedRectangle(cornerRadius: 18, style: .continuous)
                                    .stroke(
                                        image.url == displayedImageURL ? ProductPalette.primary : ProductPalette.border,
                                        lineWidth: image.url == displayedImageURL ? 2.5 : 1
                                    )
                            }
                    }
                    .buttonStyle(.plain)
                    .accessibilityLabel(image.altText ?? productTitle)
                }
            }
            .padding(.vertical, 2)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
