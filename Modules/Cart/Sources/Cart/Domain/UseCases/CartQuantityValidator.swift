enum CartQuantityValidator {
    static func validate(requestedQuantity: Int, availableQuantity: Int?) throws {
        guard requestedQuantity > 0 else {
            throw CartError.invalidQuantity(requestedQuantity)
        }

        guard let availableQuantity else {
            return
        }

        guard requestedQuantity <= availableQuantity else {
            throw CartError.quantityLimitExceeded(
                quantity: requestedQuantity,
                maximumQuantity: availableQuantity
            )
        }
    }
}
