import Foundation
import MarktekNetworking

public protocol CheckoutRemoteDataSource: Sendable {
    func createDraftOrder(input: DraftOrderCreateInput) async throws -> DraftOrderDataModel
    func applyDraftOrderDiscount(draftOrderId: String, discount: DiscountInput) async throws -> DraftOrderDataModel
    func completeDraftOrder(draftOrderId: String, paymentPending: Bool) async throws -> CompletedOrderDataModel
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

    public func applyDraftOrderDiscount(draftOrderId: String, discount: DiscountInput) async throws -> DraftOrderDataModel {
        // NOTE: The `draftOrderUpdate` mutation replaces/overwrites the specific fields sent in `DraftOrderInput`.
        // Passing only `appliedDiscount` in `DraftOrderInput` allows updating the discount without affecting the
        // existing lineItems or shipping address on the draft order. However, if other fields are sent,
        // they will override the remote values, so be careful not to lose original order data.
        
        let type: GraphQLEnum<DraftOrderAppliedDiscountType>
        switch discount.valueType {
        case .percentage:
            type = .case(.percentage)
        case .fixedAmount:
            type = .case(.fixedAmount)
        }
        
        let appliedDiscountInput = DraftOrderAppliedDiscountInput(
            title: .some(discount.title),
            value: discount.value,
            valueType: type
        )
        
        let draftOrderInput = DraftOrderInput(
            appliedDiscount: .some(appliedDiscountInput)
        )
        
        let mutation = ApplyDiscountMutation(id: draftOrderId, input: draftOrderInput)
        let data = try await ShopifyAdminGraphQLClient.shared.perform(mutation)
        
        if let userErrors = data.draftOrderUpdate?.userErrors, !userErrors.isEmpty {
            let errorMessages = userErrors.map { $0.message }
            throw DraftOrderError.userError(errorMessages)
        }
        
        guard let gqlDraftOrder = data.draftOrderUpdate?.draftOrder else {
            throw DraftOrderError.unknown
        }
        
        return DraftOrderDataModel(gqlDraftOrder: gqlDraftOrder)
    }

    public func completeDraftOrder(draftOrderId: String, paymentPending: Bool) async throws -> CompletedOrderDataModel {
        let mutation = CompleteDraftOrderMutation(id: draftOrderId, paymentPending: .some(paymentPending))
        let data = try await ShopifyAdminGraphQLClient.shared.perform(mutation)
        
        if let userErrors = data.draftOrderComplete?.userErrors, !userErrors.isEmpty {
            let errorMessages = userErrors.map { $0.message }
            throw DraftOrderError.userError(errorMessages)
        }
        
        guard let gqlDraftOrder = data.draftOrderComplete?.draftOrder else {
            throw DraftOrderError.unknown
        }
        
        return CompletedOrderDataModel(gqlDraftOrder: gqlDraftOrder)
    }
}
