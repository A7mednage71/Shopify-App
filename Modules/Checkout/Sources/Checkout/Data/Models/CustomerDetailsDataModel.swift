import Foundation

public struct CustomerDetailsDataModel: Sendable {
    public let id: String
    public let email: String?
    public let phone: String?
    public let firstName: String?
    public let lastName: String?
    public let defaultAddress: CheckoutAddress?

    public init(
        id: String,
        email: String?,
        phone: String?,
        firstName: String?,
        lastName: String?,
        defaultAddress: CheckoutAddress?
    ) {
        self.id = id
        self.email = email
        self.phone = phone
        self.firstName = firstName
        self.lastName = lastName
        self.defaultAddress = defaultAddress
    }
}
