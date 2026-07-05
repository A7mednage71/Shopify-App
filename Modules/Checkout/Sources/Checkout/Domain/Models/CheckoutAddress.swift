import Foundation

public struct CheckoutAddress: Equatable, Sendable {
    public let title: String
    public let street: String
    public let city: String
    public let region: String
    public let postalCode: String
    public let firstName: String?
    public let lastName: String?
    public let company: String?
    public let street2: String?
    public let countryCode: String?
    public let phone: String?

    public init(
        title: String,
        street: String,
        city: String,
        region: String,
        postalCode: String,
        firstName: String? = nil,
        lastName: String? = nil,
        company: String? = nil,
        street2: String? = nil,
        countryCode: String? = nil,
        phone: String? = nil
    ) {
        self.title = title
        self.street = street
        self.city = city
        self.region = region
        self.postalCode = postalCode
        self.firstName = firstName
        self.lastName = lastName
        self.company = company
        self.street2 = street2
        self.countryCode = countryCode
        self.phone = phone
    }
}
