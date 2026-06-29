struct AddCartLineRequest: Equatable, Sendable {
    let merchandiseID: String
    let quantity: Int

    init(merchandiseID: String, quantity: Int) {
        self.merchandiseID = merchandiseID
        self.quantity = quantity
    }
}

struct UpdateCartLineRequest: Equatable, Sendable {
    let lineID: String
    let quantity: Int
    let merchandiseID: String?

    init(lineID: String, quantity: Int, merchandiseID: String? = nil) {
        self.lineID = lineID
        self.quantity = quantity
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
