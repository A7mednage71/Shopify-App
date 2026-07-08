import Foundation
import MarktekNetworking
import ApolloAPI

public struct ProductReviewSubmission: Equatable, Sendable {
    public let productId: String
    public let customerName: String
    public let rating: Int
    public let title: String
    public let body: String

    public init(
        productId: String,
        customerName: String,
        rating: Int,
        title: String,
        body: String
    ) {
        self.productId = productId
        self.customerName = customerName
        self.rating = rating
        self.title = title
        self.body = body
    }
}

public enum ProductReviewError: LocalizedError {
    case userError([String])
    case malformedReviewsMetafield
    case unknown

    public var errorDescription: String? {
        switch self {
        case .userError(let messages):
            return messages.joined(separator: ", ")
        case .malformedReviewsMetafield:
            return "Could not read existing product reviews. Please try again."
        case .unknown:
            return "An unknown error occurred while submitting your review."
        }
    }
}

public protocol ProductReviewRepositoryProtocol: Sendable {
    func submitProductReview(_ review: ProductReviewSubmission) async throws
}

public struct ProductReviewRepository: ProductReviewRepositoryProtocol, Sendable {
    
    public init() {}

    public func submitProductReview(_ review: ProductReviewSubmission) async throws {
        var reviewIds = try await fetchExistingReviewIds(productId: review.productId)
        let newReviewId = try await createProductReview(review)

        if !reviewIds.contains(newReviewId) {
            reviewIds.append(newReviewId)
        }

        try await setProductReviewIds(
            productId: review.productId,
            reviewIds: reviewIds
        )
    }

    private func fetchExistingReviewIds(productId: String) async throws -> [String] {
        let data = try await ShopifyGraphQLClient.shared.fetch(
            GetProductReviewMetafieldQuery(productId: productId)
        )

        guard let value = data.product?.metafield?.value,
              !value.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            return []
        }

        guard let jsonData = value.data(using: .utf8),
              let ids = try? JSONDecoder().decode([String].self, from: jsonData) else {
            throw ProductReviewError.malformedReviewsMetafield
        }

        return ids
    }

    private func createProductReview(_ review: ProductReviewSubmission) async throws -> String {
        let mutation = CreateProductReviewMutation(
            metaobject: ShopifyAdminAPI.MetaobjectCreateInput(
                type: "marketak_product_review",
                fields: .some([
                    ShopifyAdminAPI.MetaobjectFieldInput(key: "product", value: review.productId),
                    ShopifyAdminAPI.MetaobjectFieldInput(key: "customer_name", value: review.customerName),
                    ShopifyAdminAPI.MetaobjectFieldInput(key: "rating", value: "\(review.rating)"),
                    ShopifyAdminAPI.MetaobjectFieldInput(key: "title", value: review.title),
                    ShopifyAdminAPI.MetaobjectFieldInput(key: "body", value: review.body),
                    ShopifyAdminAPI.MetaobjectFieldInput(key: "created_at", value: currentISO8601DateString()),
                    ShopifyAdminAPI.MetaobjectFieldInput(key: "approved", value: "true")
                ]),
                capabilities: .some(
                    ShopifyAdminAPI.MetaobjectCapabilityDataInput(
                        publishable: .some(
                            ShopifyAdminAPI.MetaobjectCapabilityDataPublishableInput(
                                status: GraphQLEnum<ShopifyAdminAPI.MetaobjectStatus>(.active)
                            )
                        )
                    )
                )
            )
        )

        let data = try await ShopifyAdminGraphQLClient.shared.perform(mutation)

        if let userErrors = data.metaobjectCreate?.userErrors, !userErrors.isEmpty {
            throw ProductReviewError.userError(userErrors.map { $0.message })
        }

        guard let metaobjectId = data.metaobjectCreate?.metaobject?.id else {
            throw ProductReviewError.unknown
        }

        return metaobjectId
    }

    private func setProductReviewIds(productId: String, reviewIds: [String]) async throws {
        let jsonData = try JSONEncoder().encode(reviewIds)
        guard let reviewIdsJson = String(data: jsonData, encoding: .utf8) else {
            throw ProductReviewError.unknown
        }

        let data = try await ShopifyAdminGraphQLClient.shared.perform(
            SetProductReviewsMutation(
                productId: productId,
                reviewIdsJson: reviewIdsJson
            )
        )

        if let userErrors = data.metafieldsSet?.userErrors, !userErrors.isEmpty {
            throw ProductReviewError.userError(userErrors.map { $0.message })
        }
    }

    private func currentISO8601DateString() -> String {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime]
        return formatter.string(from: Date())
    }
}
