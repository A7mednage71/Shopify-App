import Foundation
import Common

public enum CartError: Error, Equatable, Sendable {
    case missingCartID
    case staleCart
    case invalidQuantity(Int)
    case quantityLimitExceeded(quantity: Int, maximumQuantity: Int)
    case userErrors([CartUserError])
    case malformedResponse(String)
}

extension CartError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .missingCartID:
            return L10n.Cart.errorMissingCartID
        case .staleCart:
            return L10n.Cart.errorStaleCart
        case let .invalidQuantity(quantity):
            return L10n.Cart.invalidQuantityMessage(quantity)
        case let .quantityLimitExceeded(quantity, maximumQuantity):
            return L10n.Cart.quantityLimitExceededMessage(quantity: quantity, maximumQuantity: maximumQuantity)
        case let .userErrors(errors):
            return errors.map(\.message).joined(separator: "\n")
        case let .malformedResponse(message):
            return message
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
