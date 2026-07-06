import Foundation

extension CustomerDetailsDataModel {
    public func toDomain() -> CustomerDetails {
        return CustomerDetails(
            id: id,
            email: email,
            phone: phone,
            firstName: firstName,
            lastName: lastName,
            defaultAddress: defaultAddress
        )
    }
}
