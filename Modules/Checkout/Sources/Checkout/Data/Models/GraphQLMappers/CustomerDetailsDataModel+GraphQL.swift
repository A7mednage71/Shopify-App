import Foundation
import MarktekNetworking

extension CustomerDetailsDataModel {
    public init(gqlCustomer: GetCustomerDetailsQuery.Data.Customer) {
        self.id = gqlCustomer.id
        self.email = gqlCustomer.email
        self.phone = gqlCustomer.phone
        self.firstName = gqlCustomer.firstName
        self.lastName = gqlCustomer.lastName
        
        if let gqlAddress = gqlCustomer.defaultAddress {
            self.defaultAddress = CheckoutAddress(
                title: "Default Address",
                street: gqlAddress.address1 ?? "",
                city: gqlAddress.city ?? "",
                region: gqlAddress.provinceCode ?? "",
                postalCode: gqlAddress.zip ?? "",
                firstName: gqlAddress.firstName,
                lastName: gqlAddress.lastName,
                company: gqlAddress.company,
                street2: gqlAddress.address2,
                countryCode: gqlAddress.countryCodeV2?.rawValue,
                phone: gqlAddress.phone
            )
        } else {
            self.defaultAddress = nil
        }
    }
}
