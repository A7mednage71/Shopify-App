struct CartRepositoryImpl: CartRepository, Sendable {
    private let localDataSource: any CartLocalDataSource
    private let remoteDataSource: any CartRemoteDataSource
    private let cartManager: any CartManager

    init(
        localDataSource: any CartLocalDataSource,
        remoteDataSource: any CartRemoteDataSource,
        cartManager: any CartManager
    ) {
        self.localDataSource = localDataSource
        self.remoteDataSource = remoteDataSource
        self.cartManager = cartManager
    }

    func createCart(lines: [AddCartLineRequest]) async throws -> CartDetails {
        let cart = try await remoteDataSource.createCart(
            lines: lines,
            customerAccessToken: localDataSource.customerAccessToken
        ).toDomain()
        cartManager.save(cartID: cart.id)

        return cart
    }

    func getCurrentCart() async throws -> CartDetails {
        guard let cartID = cartManager.cartID else {
            return try await createCart(lines: [])
        }

        do {
            guard let cart = try await remoteDataSource.getCart(cartID: cartID)?.toDomain() else {
                cartManager.clearCartID()
                return try await createCart(lines: [])
            }

            return cart
        } catch where error.isRecoverableStaleCartError {
            cartManager.clearCartID()
            return try await createCart(lines: [])
        }
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
