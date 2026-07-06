import Common
import Contacts
import Foundation
import PassKit

#if os(iOS)
struct ApplePayPaymentRequestFactory {
    let supportedNetworks: [PKPaymentNetwork] = [.visa, .masterCard, .amex]

    func makeRequest(
        customerDetails: CustomerDetails,
        pricing: CheckoutPricing,
        configuration: CheckoutApplePayConfiguration
    ) -> PKPaymentRequest {
        let request = PKPaymentRequest()
        request.merchantIdentifier = configuration.merchantIdentifier
        request.countryCode = configuration.countryCode
        request.currencyCode = pricing.currencyCode
        request.supportedNetworks = supportedNetworks
        request.merchantCapabilities = [.capability3DS]
        request.paymentSummaryItems = paymentSummaryItems(
            pricing: pricing,
            merchantDisplayName: configuration.merchantDisplayName
        )
        request.shippingContact = paymentContact(
            customerDetails: customerDetails,
            address: customerDetails.defaultAddress
        )

        return request
    }

    private func paymentSummaryItems(
        pricing: CheckoutPricing,
        merchantDisplayName: String
    ) -> [PKPaymentSummaryItem] {
        var items = [
            PKPaymentSummaryItem(
                label: CheckoutText.subtotalTitle,
                amount: NSDecimalNumber(decimal: pricing.subtotal)
            )
        ]

        if pricing.discountAmount > 0 {
            items.append(
                PKPaymentSummaryItem(
                    label: CheckoutText.discountTitle,
                    amount: NSDecimalNumber(decimal: -pricing.discountAmount)
                )
            )
        }

        items.append(
            PKPaymentSummaryItem(
                label: pricing.shippingMethod.title,
                amount: NSDecimalNumber(decimal: pricing.shippingAmount)
            )
        )
        items.append(
            PKPaymentSummaryItem(
                label: merchantDisplayName,
                amount: NSDecimalNumber(decimal: pricing.total),
                type: .final
            )
        )

        return items
    }

    private func paymentContact(
        customerDetails: CustomerDetails,
        address: CheckoutAddress?
    ) -> PKContact? {
        guard customerDetails.email != nil || customerDetails.phone != nil || address != nil else {
            return nil
        }

        let contact = PKContact()
        contact.emailAddress = customerDetails.email

        if let phone = customerDetails.phone ?? address?.phone {
            contact.phoneNumber = CNPhoneNumber(stringValue: phone)
        }

        if let address {
            var name = PersonNameComponents()
            name.givenName = address.firstName ?? customerDetails.firstName
            name.familyName = address.lastName ?? customerDetails.lastName
            contact.name = name

            let postalAddress = CNMutablePostalAddress()
            postalAddress.street = [address.street, address.street2].compactMap { $0 }.joined(separator: "\n")
            postalAddress.city = address.city
            postalAddress.state = address.region
            postalAddress.postalCode = address.postalCode
            postalAddress.isoCountryCode = address.countryCode ?? ""
            contact.postalAddress = postalAddress
        }

        return contact
    }
}
#endif
