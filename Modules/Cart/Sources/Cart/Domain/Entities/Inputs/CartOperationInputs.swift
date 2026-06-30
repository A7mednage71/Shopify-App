struct AddCartLineRequest: Equatable, Sendable {
    let merchandiseID: String
    let quantity: Int
    let availableQuantity: Int?

    init(merchandiseID: String, quantity: Int, availableQuantity: Int? = nil) {
        self.merchandiseID = merchandiseID
        self.quantity = quantity
        self.availableQuantity = availableQuantity
    }
}

struct UpdateCartLineRequest: Equatable, Sendable {
    let lineID: String
    let quantity: Int
    let availableQuantity: Int?
    let merchandiseID: String?

    init(
        lineID: String,
        quantity: Int,
        availableQuantity: Int? = nil,
        merchandiseID: String? = nil
    ) {
        self.lineID = lineID
        self.quantity = quantity
        self.availableQuantity = availableQuantity
        self.merchandiseID = merchandiseID
    }
}

struct UpdateCartLinesInput: Equatable, Sendable {
    let lines: [UpdateCartLineRequest]

    init(lines: [UpdateCartLineRequest]) {
        self.lines = lines
    }
}

struct RemoveCartLinesInput: Equatable, Sendable {
    let lineIDs: [String]

    init(lineIDs: [String]) {
        self.lineIDs = lineIDs
    }
}

struct ApplyDiscountCodesInput: Equatable, Sendable {
    let discountCodes: [String]

    init(discountCodes: [String]) {
        self.discountCodes = discountCodes
    }
}
