@preconcurrency import MarktekNetworking
import Common

struct ShopifyCartRemoteDataSource: CartRemoteDataSource, Sendable {
    private let localizationManager: LocalizationManager

    init(localizationManager: LocalizationManager) {
        self.localizationManager = localizationManager
    }

    func createCart(lines: [AddCartLineRequest], customerAccessToken: String) async throws -> CartDataModel {
        let mutation = try CreateCartMutation(
            input: CartInput(
                lines: lines.isEmpty ? nil : .some(lines.map { try $0.toGraphQLInput() }),
                buyerIdentity: .some(
                    CartBuyerIdentityInput(
                        customerAccessToken: .some(customerAccessToken)
                    )
                )
            )
        )
        let data = try await ShopifyGraphQLClient.shared.perform(mutation)

        guard let payload = data.cartCreate else {
            throw CartError.malformedResponse(L10n.Cart.malformedCreatePayload)
        }

        try payload.userErrors.throwIfNeeded()

        guard let cart = payload.cart else {
            throw CartError.malformedResponse(L10n.Cart.malformedCreateCart)
        }

        return CartDataModel(cart: cart)
    }

    func getCart(cartID: String) async throws -> CartDataModel? {
        let language: GraphQLEnum<LanguageCode> = localizationManager.currentLanguage == .en ? .case(.en) : .case(.ar)
        let data = try await ShopifyGraphQLClient.shared.fetch(GetCartQuery(cartId: cartID, language: .some(language)))

        return data.cart.map { CartDataModel(cart: $0) }
    }

    func addLines(cartID: String, lines: [AddCartLineRequest]) async throws -> CartDataModel {
        let mutation = try AddCartLinesMutation(
            cartId: cartID,
            lines: lines.map { try $0.toGraphQLInput() }
        )
        let data = try await ShopifyGraphQLClient.shared.perform(mutation)

        guard let payload = data.cartLinesAdd else {
            throw CartError.malformedResponse(L10n.Cart.malformedAddPayload)
        }

        try payload.userErrors.throwIfNeeded()

        guard let cart = payload.cart else {
            throw CartError.malformedResponse(L10n.Cart.malformedAddCart)
        }

        return CartDataModel(cart: cart)
    }

    func updateLines(cartID: String, lines: [UpdateCartLineRequest]) async throws -> CartDataModel {
        let mutation = try UpdateCartLinesMutation(
            cartId: cartID,
            lines: lines.map { try $0.toGraphQLInput() }
        )
        let data = try await ShopifyGraphQLClient.shared.perform(mutation)

        guard let payload = data.cartLinesUpdate else {
            throw CartError.malformedResponse(L10n.Cart.malformedUpdatePayload)
        }

        try payload.userErrors.throwIfNeeded()

        guard let cart = payload.cart else {
            throw CartError.malformedResponse(L10n.Cart.malformedUpdateCart)
        }

        return CartDataModel(cart: cart)
    }

    func removeLines(cartID: String, lineIDs: [String]) async throws -> CartDataModel {
        let data = try await ShopifyGraphQLClient.shared.perform(
            RemoveCartLinesMutation(cartId: cartID, lineIds: lineIDs)
        )

        guard let payload = data.cartLinesRemove else {
            throw CartError.malformedResponse(L10n.Cart.malformedRemovePayload)
        }

        try payload.userErrors.throwIfNeeded()

        guard let cart = payload.cart else {
            throw CartError.malformedResponse(L10n.Cart.malformedRemoveCart)
        }

        return CartDataModel(cart: cart)
    }

    func applyDiscountCodes(cartID: String, discountCodes: [String]) async throws -> CartDataModel {
        let data = try await ShopifyGraphQLClient.shared.perform(
            ApplyDiscountCodeMutation(cartId: cartID, discountCodes: discountCodes)
        )

        guard let payload = data.cartDiscountCodesUpdate else {
            throw CartError.malformedResponse(L10n.Cart.malformedDiscountPayload)
        }

        try payload.userErrors.throwIfNeeded()

        guard let cart = payload.cart else {
            throw CartError.malformedResponse(L10n.Cart.malformedDiscountCart)
        }

        return CartDataModel(cart: cart)
    }
}

private extension AddCartLineRequest {
    func toGraphQLInput() throws -> CartLineInput {
        try CartLineInput(
            quantity: .some(quantity),
            merchandiseId: merchandiseID
        )
    }
}

private extension UpdateCartLineRequest {
    func toGraphQLInput() throws -> CartLineUpdateInput {
        try CartLineUpdateInput(
            id: lineID,
            quantity: .some(quantity),
            merchandiseId: merchandiseID.map { .some($0) } ?? nil
        )
    }
}

private extension Int {
    func toGraphQLQuantity() throws -> Int32 {
        guard self > 0 else {
            throw CartError.invalidQuantity(self)
        }

        guard self <= Int(Int32.max) else {
            throw CartError.invalidQuantity(self)
        }

        return Int32(self)
    }
}

private extension Array where Element == CartUserErrorDataModel {
    func throwIfNeeded() throws {
        guard !isEmpty else { return }

        throw CartError.userErrors(map { $0.toDomain() })
    }
}

private extension Array where Element == CreateCartMutation.Data.CartCreate.UserError {
    func throwIfNeeded() throws {
        try map { CartUserErrorDataModel(userError: $0) }.throwIfNeeded()
    }
}

private extension Array where Element == AddCartLinesMutation.Data.CartLinesAdd.UserError {
    func throwIfNeeded() throws {
        try map { CartUserErrorDataModel(userError: $0) }.throwIfNeeded()
    }
}

private extension Array where Element == UpdateCartLinesMutation.Data.CartLinesUpdate.UserError {
    func throwIfNeeded() throws {
        try map { CartUserErrorDataModel(userError: $0) }.throwIfNeeded()
    }
}

private extension Array where Element == RemoveCartLinesMutation.Data.CartLinesRemove.UserError {
    func throwIfNeeded() throws {
        try map { CartUserErrorDataModel(userError: $0) }.throwIfNeeded()
    }
}

private extension Array where Element == ApplyDiscountCodeMutation.Data.CartDiscountCodesUpdate.UserError {
    func throwIfNeeded() throws {
        try map { CartUserErrorDataModel(userError: $0) }.throwIfNeeded()
    }
}
