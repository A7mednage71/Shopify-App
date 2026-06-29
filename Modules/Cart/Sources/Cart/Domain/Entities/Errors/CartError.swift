import Foundation

public enum CartError: Error, Equatable, Sendable {
    case missingCartID
    case staleCart
    case invalidQuantity(Int)
    case userErrors([CartUserError])
    case malformedResponse(String)
}

extension CartError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .missingCartID:
            "No cart id is saved."
        case .staleCart:
            "The saved cart no longer exists."
        case let .invalidQuantity(quantity):
            "Cart item quantity must be greater than zero. Received \(quantity)."
        case let .userErrors(errors):
            errors.map(\.message).joined(separator: "\n")
        case let .malformedResponse(message):
            message
        }
    }
}

public struct CartUserError: Equatable, Sendable {
    public let code: String?
    public let field: [String]
    public let message: String

    public init(code: String?, field: [String], message: String) {
        self.code = code
        self.field = field
        self.message = message
    }
}
