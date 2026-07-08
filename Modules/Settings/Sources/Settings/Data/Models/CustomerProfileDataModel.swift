import Foundation
import MarktekNetworking

struct CustomerProfileDataModel: Sendable {
    let id: String
    let firstName: String?
    let lastName: String?
    let email: String?
    let phone: String?
    let createdAt: String

    init(customer: GetCustomerProfileQuery.Data.Customer) {
        self.id = customer.id
        self.firstName = customer.firstName
        self.lastName = customer.lastName
        self.email = customer.email
        self.phone = customer.phone
        self.createdAt = customer.createdAt
    }

    init(customer: UpdateCustomerProfileMutation.Data.CustomerUpdate.Customer) {
        self.id = customer.id
        self.firstName = customer.firstName
        self.lastName = customer.lastName
        self.email = customer.email
        self.phone = customer.phone
        self.createdAt = customer.createdAt
    }

    func toDomain() -> CustomerProfile {
        CustomerProfile(
            id: id,
            firstName: firstName,
            lastName: lastName,
            email: email,
            phone: phone,
            createdAt: createdAt
        )
    }
}
