import Foundation

protocol SubmitProductReviewUseCaseProtocol: Sendable {
    func execute(
        input: ProductReviewInput,
        customerDetails: CustomerDetails
    ) async throws
}

enum SubmitProductReviewUseCaseError: LocalizedError, Equatable {
    case invalidRating
    case missingTitle
    case missingBody

    var errorDescription: String? {
        switch self {
        case .invalidRating:
            return "Choose a rating before submitting your review."
        case .missingTitle:
            return "Add a title for your review."
        case .missingBody:
            return "Add a few words about your experience."
        }
    }
}

struct SubmitProductReviewUseCase: SubmitProductReviewUseCaseProtocol, Sendable {
    private let repository: CheckoutRepository

    init(repository: CheckoutRepository) {
        self.repository = repository
    }

    func execute(
        input: ProductReviewInput,
        customerDetails: CustomerDetails
    ) async throws {
        guard (1...5).contains(input.rating) else {
            throw SubmitProductReviewUseCaseError.invalidRating
        }

        let title = input.title.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !title.isEmpty else {
            throw SubmitProductReviewUseCaseError.missingTitle
        }

        let body = input.body.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !body.isEmpty else {
            throw SubmitProductReviewUseCaseError.missingBody
        }

        try await repository.submitProductReview(
            ProductReviewSubmission(
                productId: input.productId,
                customerName: customerName(from: customerDetails),
                rating: input.rating,
                title: title,
                body: body
            )
        )
    }

    private func customerName(from customerDetails: CustomerDetails) -> String {
        let name = [customerDetails.firstName, customerDetails.lastName]
            .compactMap { $0?.trimmingCharacters(in: .whitespacesAndNewlines) }
            .filter { !$0.isEmpty }
            .joined(separator: " ")

        return name.isEmpty ? "Customer" : name
    }
}

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
