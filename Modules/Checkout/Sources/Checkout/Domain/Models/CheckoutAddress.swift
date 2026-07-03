public struct CheckoutAddress: Equatable, Sendable {
    public let title: String
    public let street: String
    public let city: String
    public let region: String
    public let postalCode: String

    public init(
        title: String,
        street: String,
        city: String,
        region: String,
        postalCode: String
    ) {
        self.title = title
        self.street = street
        self.city = city
        self.region = region
        self.postalCode = postalCode
    }
}
