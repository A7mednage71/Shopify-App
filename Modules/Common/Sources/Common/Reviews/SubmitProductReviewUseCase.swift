import Foundation

public protocol SubmitProductReviewUseCaseProtocol: Sendable {
    func execute(
        input: ProductReviewInput,
        customerName: String
    ) async throws
}

public enum SubmitProductReviewUseCaseError: LocalizedError, Equatable {
    case invalidRating
    case missingTitle
    case missingBody

    public var errorDescription: String? {
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

public struct SubmitProductReviewUseCase: SubmitProductReviewUseCaseProtocol, Sendable {
    private let repository: ProductReviewRepositoryProtocol

    public init(repository: ProductReviewRepositoryProtocol = ProductReviewRepository()) {
        self.repository = repository
    }

    public func execute(
        input: ProductReviewInput,
        customerName: String
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
                customerName: customerName,
                rating: input.rating,
                title: title,
                body: body
            )
        )
    }
}
