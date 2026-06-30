import Foundation

extension Error {
    var isRecoverableStaleCartError: Bool {
        if let cartError = self as? CartError {
            return cartError.isRecoverableStaleCartError
        }

        let message = localizedDescription.lowercased()

        return message.contains("invalid global id")
            || message.contains("invalid cart id")
            || message.contains("invalid cartid")
            || message.contains("cart id is invalid")
            || message.contains("cartid is invalid")
            || message.contains("cart not found")
            || message.contains("cart does not exist")
    }
}

private extension CartError {
    var isRecoverableStaleCartError: Bool {
        switch self {
        case .staleCart:
            true
        case let .userErrors(errors):
            errors.contains { userError in
                userError.looksLikeStaleCartError
            }
        case .missingCartID,
             .invalidQuantity,
             .quantityLimitExceeded,
             .malformedResponse:
            false
        }
    }
}

private extension CartUserError {
    var looksLikeStaleCartError: Bool {
        let codeText = code?.lowercased() ?? ""
        let messageText = message.lowercased()
        let fieldText = field.joined(separator: ".").lowercased()
        let combinedText = "\(codeText) \(messageText) \(fieldText)"

        return combinedText.contains("cartid")
            || combinedText.contains("cart id")
            || combinedText.contains("invalid global id")
            || (combinedText.contains("cart") && combinedText.contains("not found"))
            || (combinedText.contains("cart") && combinedText.contains("does not exist"))
    }
}
