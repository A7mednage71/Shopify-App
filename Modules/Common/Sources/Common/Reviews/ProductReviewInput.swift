import Foundation

public struct ProductReviewInput: Equatable, Sendable {
    public let productId: String
    public let rating: Int
    public let title: String
    public let body: String

    public init(
        productId: String,
        rating: Int,
        title: String,
        body: String
    ) {
        self.productId = productId
        self.rating = rating
        self.title = title
        self.body = body
    }
}
