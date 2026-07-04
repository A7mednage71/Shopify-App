import Foundation
import MarktekNetworking

public protocol CheckoutRemoteDataSource: Sendable {
    func createDraftOrder(input: DraftOrderCreateInput) async throws -> DraftOrderDataModel
}

public struct ShopifyCheckoutRemoteDataSource: CheckoutRemoteDataSource, Sendable {
    
    public init() {}

    public func createDraftOrder(input: DraftOrderCreateInput) async throws -> DraftOrderDataModel {
        let gqlLineItems = input.lineItems.map { item in
            DraftOrderLineItemInput(
                quantity: item.quantity,
                variantId: .some(item.variantId)
            )
        }

        let shippingAddressInput: GraphQLNullable<MailingAddressInput>
        if let address = input.shippingAddress {
            shippingAddressInput = .some(MailingAddressInput(
                address1: .some(address.street),
                city: .some(address.city),
                provinceCode: .some(address.region),
                zip: .some(address.postalCode)
            ))
        } else {
            shippingAddressInput = .none
        }

        let draftOrderInput = DraftOrderInput(
            lineItems: .some(gqlLineItems),
            shippingAddress: shippingAddressInput
        )

        let mutation = CreateDraftOrderMutation(input: draftOrderInput)
        let data = try await ShopifyAdminGraphQLClient.shared.perform(mutation)

        if let userErrors = data.draftOrderCreate?.userErrors, !userErrors.isEmpty {
            let errorMessages = userErrors.map { $0.message }
            throw DraftOrderError.userError(errorMessages)
        }

        guard let gqlDraftOrder = data.draftOrderCreate?.draftOrder else {
            throw DraftOrderError.unknown
        }

        return DraftOrderDataModel(gqlDraftOrder: gqlDraftOrder)
    }
}
