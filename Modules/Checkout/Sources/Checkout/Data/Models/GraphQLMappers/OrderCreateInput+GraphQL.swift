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

        let gqlShippingLines = shippingLines.map { shippingLine in
            ShopifyAdminAPI.OrderCreateShippingLineInput(
                code: .some(shippingLine.code),
                priceSet: moneyBag(amount: shippingLine.amount, currencyCode: shippingLine.currencyCode),
                source: .some(shippingLine.source),
                title: shippingLine.title
            )
        }

        let discountInput = discountCode.map { discountCode in
            switch discountCode {
            case .itemFixed(let code, let amount, let currencyCode):
                let fixedDiscount = ShopifyAdminAPI.OrderCreateFixedDiscountCodeAttributesInput(
                    code: code,
                    amountSet: .some(moneyBag(amount: amount, currencyCode: currencyCode))
                )

                return ShopifyAdminAPI.OrderCreateDiscountCodeInput(
                    itemFixedDiscountCode: .some(fixedDiscount)
                )

            case .itemPercentage(let code, let percentage):
                let percentageDiscount = ShopifyAdminAPI.OrderCreatePercentageDiscountCodeAttributesInput(
                    code: code,
                    percentage: .some(percentage)
                )

                return ShopifyAdminAPI.OrderCreateDiscountCodeInput(
                    itemPercentageDiscountCode: .some(percentageDiscount)
                )

            case .freeShipping(let code):
                let freeShippingDiscount = ShopifyAdminAPI.OrderCreateFreeShippingDiscountCodeAttributesInput(
                    code: code
                )

                return ShopifyAdminAPI.OrderCreateDiscountCodeInput(
                    freeShippingDiscountCode: .some(freeShippingDiscount)
                )
            }
        }

        let transaction = ShopifyAdminAPI.OrderCreateOrderTransactionInput(
            amountSet: moneyBag(amount: totalAmount, currencyCode: currency),
            gateway: .some(transactionGateway),
            kind: .some(GraphQLEnum<ShopifyAdminAPI.OrderTransactionKind>(.sale)),
            status: .some(GraphQLEnum<ShopifyAdminAPI.OrderTransactionStatus>(rawValue: transactionStatus.rawValue)),
            test: .none
        )

        return OrderCreateOrderInput(
            buyerAcceptsMarketing: .none,
            currency: .some(GraphQLEnum<ShopifyAdminAPI.CurrencyCode>(rawValue: currency)),
            customer: customerInput,
            discountCode: discountInput.map { GraphQLNullable.some($0) } ?? .none,
            email: email.map { .some($0) } ?? .none,
            financialStatus: .some(GraphQLEnum<ShopifyAdminAPI.OrderCreateFinancialStatus>(rawValue: financialStatus.rawValue)),
            lineItems: .some(gqlLineItems),
            phone: phone.map { .some($0) } ?? .none,
            shippingAddress: shippingAddressInput,
            shippingLines: gqlShippingLines.isEmpty ? .none : .some(gqlShippingLines),
            taxesIncluded: .none,
            test: .none,
            transactions: .some([transaction])
        )
    }

    public func toGraphQLOptionsInput() -> GraphQLNullable<ShopifyAdminAPI.OrderCreateOptionsInput> {
        .some(
            ShopifyAdminAPI.OrderCreateOptionsInput(
                inventoryBehaviour: .none,
                sendReceipt: .some(sendReceipt),
                sendFulfillmentReceipt: .some(sendFulfillmentReceipt)
            )
        )
    }

    private func moneyBag(amount: Foundation.Decimal, currencyCode: String) -> ShopifyAdminAPI.MoneyBagInput {
        let money = ShopifyAdminAPI.MoneyInput(
            amount: amount.description,
            currencyCode: GraphQLEnum<ShopifyAdminAPI.CurrencyCode>(rawValue: currencyCode)
        )

        return ShopifyAdminAPI.MoneyBagInput(shopMoney: money)
    }
}
