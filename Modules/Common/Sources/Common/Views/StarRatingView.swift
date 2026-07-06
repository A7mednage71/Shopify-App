import SwiftUI

public struct StarRatingView: View {
    public let rating: Double
    public let size: CGFloat
    public let maxStars: Int

    public init(rating: Double, size: CGFloat, maxStars: Int = 5) {
        self.rating = rating
        self.size = size
        self.maxStars = maxStars
    }

    public var body: some View {
        HStack(spacing: 2) {
            ForEach(1...maxStars, id: \.self) { star in
                starImage(for: star)
                    .font(.system(size: size))
            }
        }
    }

    @ViewBuilder
    private func starImage(for star: Int) -> some View {
        let filled    = Double(star) <= rating
        let halfFilled = !filled && Double(star) - 0.5 <= rating

        if filled {
            Image(systemName: "star.fill").foregroundColor(.appStarFilled)
        } else if halfFilled {
            Image(systemName: "star.leadinghalf.filled").foregroundColor(.appStarFilled)
        } else {
            Image(systemName: "star").foregroundColor(.appStarEmpty)
        }
    }
}
