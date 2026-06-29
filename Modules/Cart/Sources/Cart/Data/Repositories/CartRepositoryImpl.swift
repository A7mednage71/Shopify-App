struct CartRepositoryImpl: CartRepository, Sendable {
    private let remoteDataSource: any CartRemoteDataSource
    private let cartManager: any CartManager

    init(
        remoteDataSource: any CartRemoteDataSource,
        cartManager: any CartManager
    ) {
        self.remoteDataSource = remoteDataSource
        self.cartManager = cartManager
    }

    func createCart(lines: [AddCartLineRequest]) async throws -> CartDetails {
        let cart = try await remoteDataSource.createCart(lines: lines).toDomain()
        cartManager.save(cartID: cart.id)

        return cart
    }

    func getCurrentCart() async throws -> CartDetails {
        guard let cartID = cartManager.cartID else {
            return .empty
        }

        guard let cart = try await remoteDataSource.getCart(cartID: cartID)?.toDomain() else {
            cartManager.clearCartID()
            return .empty
        }

        return cart
    }

    func addLines(lines: [AddCartLineRequest]) async throws -> CartDetails {
        guard let cartID = cartManager.cartID else {
            return try await createCart(lines: lines)
        }

        do {
            return try await remoteDataSource.addLines(cartID: cartID, lines: lines).toDomain()
        } catch where error.isRecoverableStaleCartError {
            cartManager.clearCartID()
            return try await createCart(lines: lines)
        }
    }

    func updateLines(lines: [UpdateCartLineRequest]) async throws -> CartDetails {
        guard let cartID = cartManager.cartID else {
            throw CartError.missingCartID
        }

        do {
            return try await remoteDataSource.updateLines(cartID: cartID, lines: lines).toDomain()
        } catch where error.isRecoverableStaleCartError {
            cartManager.clearCartID()
            throw CartError.staleCart
        }
    }

    func removeLines(lineIDs: [String]) async throws -> CartDetails {
        guard let cartID = cartManager.cartID else {
            throw CartError.missingCartID
        }

        do {
            return try await remoteDataSource.removeLines(cartID: cartID, lineIDs: lineIDs).toDomain()
        } catch where error.isRecoverableStaleCartError {
            cartManager.clearCartID()
            throw CartError.staleCart
        }
    }

    func applyDiscountCodes(discountCodes: [String]) async throws -> CartDetails {
        guard let cartID = cartManager.cartID else {
            throw CartError.missingCartID
        }

        do {
            return try await remoteDataSource.applyDiscountCodes(
                cartID: cartID,
                discountCodes: discountCodes
            ).toDomain()
        } catch where error.isRecoverableStaleCartError {
            cartManager.clearCartID()
            throw CartError.staleCart
        }
    }
}
