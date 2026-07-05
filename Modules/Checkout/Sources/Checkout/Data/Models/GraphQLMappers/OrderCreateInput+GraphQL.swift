import Foundation
import MarktekNetworking
import ApolloAPI

extension OrderCreateInput {
    public func toGraphQLInput() -> OrderCreateOrderInput {
        let gqlLineItems = lineItems.map { item in
            ShopifyAdminAPI.OrderCreateLineItemInput(
                giftCard: .none,
                quantity: item.quantity,
                requiresShipping: .none,
                taxable: .none,
                variantId: .some(item.variantId)
            )
        }

        var shippingAddressInput: GraphQLNullable<ShopifyAdminAPI.MailingAddressInput> = .none
        if let address = shippingAddress {
            shippingAddressInput = .some(ShopifyAdminAPI.MailingAddressInput(
                address1: .some(address.address1),
                address2: address.address2.map { .some($0) } ?? .none,
                city: .some(address.city),
                company: address.company.map { .some($0) } ?? .none,
                countryCode: .some(GraphQLEnum<ShopifyAdminAPI.CountryCode>(rawValue: address.countryCode)),
                firstName: address.firstName.map { .some($0) } ?? .none,
                lastName: .some(address.lastName),
                phone: address.phone.map { .some($0) } ?? .none,
                provinceCode: address.provinceCode.map { .some($0) } ?? .none,
                zip: .some(address.zip)
            ))
        }

        var customerInput: GraphQLNullable<ShopifyAdminAPI.OrderCreateCustomerInput> = .none
        if let customerId = customerId {
            customerInput = .some(ShopifyAdminAPI.OrderCreateCustomerInput(
                toAssociate: .some(ShopifyAdminAPI.OrderCreateAssociateCustomerAttributesInput(id: .some(customerId)))
            ))
        }

        var discountInput: GraphQLNullable<ShopifyAdminAPI.OrderCreateDiscountCodeInput> = .none
        if let discountCode = discountCode, let discountAmount = discountAmount, discountAmount > 0 {
            let money = ShopifyAdminAPI.MoneyInput(
                amount: discountAmount.description,
                currencyCode: GraphQLEnum<ShopifyAdminAPI.CurrencyCode>(rawValue: currency)
            )
            let moneyBag = ShopifyAdminAPI.MoneyBagInput(shopMoney: money)
            let fixedDiscount = ShopifyAdminAPI.OrderCreateFixedDiscountCodeAttributesInput(
                code: discountCode,
                amountSet: .some(moneyBag)
            )
            discountInput = .some(ShopifyAdminAPI.OrderCreateDiscountCodeInput(
                itemFixedDiscountCode: .some(fixedDiscount)
            ))
        }

        var transactionsInput: GraphQLNullable<[ShopifyAdminAPI.OrderCreateOrderTransactionInput]> = .none
        if financialStatus == .paid {
            let money = ShopifyAdminAPI.MoneyInput(
                amount: totalAmount.description,
                currencyCode: GraphQLEnum<ShopifyAdminAPI.CurrencyCode>(rawValue: currency)
            )
            let moneyBag = ShopifyAdminAPI.MoneyBagInput(shopMoney: money)
            let tx = ShopifyAdminAPI.OrderCreateOrderTransactionInput(
                amountSet: moneyBag,
                gateway: .some("manual"),
                kind: .some(GraphQLEnum<ShopifyAdminAPI.OrderTransactionKind>(.sale)),
                status: .some(GraphQLEnum<ShopifyAdminAPI.OrderTransactionStatus>(.success)),
                test: .none
            )
            transactionsInput = .some([tx])
        }

        return OrderCreateOrderInput(
            buyerAcceptsMarketing: .none,
            currency: .some(GraphQLEnum<ShopifyAdminAPI.CurrencyCode>(rawValue: currency)),
            customer: customerInput,
            discountCode: discountInput,
            email: email.map { .some($0) } ?? .none,
            financialStatus: .some(GraphQLEnum<ShopifyAdminAPI.OrderCreateFinancialStatus>(rawValue: financialStatus.rawValue)),
            lineItems: .some(gqlLineItems),
            phone: phone.map { .some($0) } ?? .none,
            shippingAddress: shippingAddressInput,
            taxesIncluded: .none,
            test: .none,
            transactions: transactionsInput
        )
    }
}
