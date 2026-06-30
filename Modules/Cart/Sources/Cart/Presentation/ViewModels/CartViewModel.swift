import Combine
import Foundation

@MainActor
public final class CartViewModel: ObservableObject {
    @Published public private(set) var state: CartViewState = .idle
    @Published public private(set) var errorMessage: String?

    private let getCurrentCartUseCase: any GetCurrentCartUseCaseProtocol
    private let updateCartLineQuantityUseCase: any UpdateCartLineQuantityUseCaseProtocol
    private let removeCartLineUseCase: any RemoveCartLineUseCaseProtocol
    private var pendingLineRequests: [String: PendingLineRequest] = [:]
    private var pendingLineTasks: [String: Task<Void, Never>] = [:]
    private var nextRequestID = 0

    init(
        getCurrentCartUseCase: any GetCurrentCartUseCaseProtocol,
        updateCartLineQuantityUseCase: any UpdateCartLineQuantityUseCaseProtocol,
        removeCartLineUseCase: any RemoveCartLineUseCaseProtocol
    ) {
        self.getCurrentCartUseCase = getCurrentCartUseCase
        self.updateCartLineQuantityUseCase = updateCartLineQuantityUseCase
        self.removeCartLineUseCase = removeCartLineUseCase
    }

    public func loadCart() async {
        cancelAllLineMutations()
        errorMessage = nil
        state = .loading

        do {
            let cart = try await getCurrentCartUseCase.execute()
            state = .success(cart)
        } catch {
            state = .failure(error.localizedDescription)
        }
    }

    public func increment(lineID: String) {
        changeQuantity(for: lineID, by: 1)
    }

    public func decrement(lineID: String) {
        changeQuantity(for: lineID, by: -1)
    }

    public func remove(lineID: String) {
        guard case let .success(cart) = state,
              let optimisticCart = cart.removingLine(id: lineID) else {
            return
        }

        let requestID = makeRequestID()
        let rollbackCart = pendingLineRequests[lineID]?.rollbackCart ?? cart

        errorMessage = nil
        state = .success(optimisticCart)
        startPendingRequest(lineID: lineID, requestID: requestID, rollbackCart: rollbackCart)

        pendingLineTasks[lineID] = Task { [weak self] in
            await self?.removeLineOnServer(lineID: lineID, requestID: requestID)
        }
    }

    private func changeQuantity(for lineID: String, by delta: Int) {
        guard case let .success(cart) = state,
              let line = cart.lines.first(where: { $0.id == lineID }) else {
            return
        }

        let updatedQuantity = line.quantity + delta

        guard updatedQuantity >= 1,
              let optimisticCart = cart.updatingLineQuantity(id: lineID, quantity: updatedQuantity) else {
            return
        }

        let requestID = makeRequestID()
        let rollbackCart = pendingLineRequests[lineID]?.rollbackCart ?? cart

        errorMessage = nil
        state = .success(optimisticCart)
        startPendingRequest(lineID: lineID, requestID: requestID, rollbackCart: rollbackCart)

        pendingLineTasks[lineID] = Task { [weak self] in
            await self?.updateQuantityOnServer(
                lineID: lineID,
                quantity: updatedQuantity,
                availableQuantity: line.variant?.quantityAvailable,
                requestID: requestID
            )
        }
    }

    private func updateQuantityOnServer(
        lineID: String,
        quantity: Int,
        availableQuantity: Int?,
        requestID: Int
    ) async {
        do {
            let cart = try await updateCartLineQuantityUseCase.execute(
                lineID: lineID,
                quantity: quantity,
                availableQuantity: availableQuantity
            )

            applyServerCart(cart, lineID: lineID, requestID: requestID)
        } catch is CancellationError {
            clearPendingRequest(lineID: lineID, requestID: requestID)
        } catch {
            rollbackMutation(lineID: lineID, requestID: requestID, error: error)
        }
    }

    private func removeLineOnServer(lineID: String, requestID: Int) async {
        do {
            let cart = try await removeCartLineUseCase.execute(lineID: lineID)

            applyServerCart(cart, lineID: lineID, requestID: requestID)
        } catch is CancellationError {
            clearPendingRequest(lineID: lineID, requestID: requestID)
        } catch {
            rollbackMutation(lineID: lineID, requestID: requestID, error: error)
        }
    }

    private func applyServerCart(_ cart: CartDetails, lineID: String, requestID: Int) {
        guard isLatestRequest(lineID: lineID, requestID: requestID) else { return }

        state = .success(cart)
        clearPendingRequest(lineID: lineID, requestID: requestID)
    }

    private func rollbackMutation(lineID: String, requestID: Int, error: Error) {
        guard isLatestRequest(lineID: lineID, requestID: requestID),
              let rollbackCart = pendingLineRequests[lineID]?.rollbackCart else {
            return
        }

        errorMessage = error.localizedDescription
        state = .success(rollbackCart)
        clearPendingRequest(lineID: lineID, requestID: requestID)
    }

    private func startPendingRequest(lineID: String, requestID: Int, rollbackCart: CartDetails) {
        pendingLineTasks[lineID]?.cancel()
        pendingLineRequests[lineID] = PendingLineRequest(id: requestID, rollbackCart: rollbackCart)
    }

    private func isLatestRequest(lineID: String, requestID: Int) -> Bool {
        pendingLineRequests[lineID]?.id == requestID
    }

    private func clearPendingRequest(lineID: String, requestID: Int) {
        guard isLatestRequest(lineID: lineID, requestID: requestID) else { return }

        pendingLineTasks[lineID] = nil
        pendingLineRequests[lineID] = nil
    }

    private func cancelAllLineMutations() {
        pendingLineTasks.values.forEach { $0.cancel() }
        pendingLineTasks.removeAll()
        pendingLineRequests.removeAll()
    }

    private func makeRequestID() -> Int {
        nextRequestID += 1

        return nextRequestID
    }
}

private struct PendingLineRequest {
    let id: Int
    let rollbackCart: CartDetails
}

private extension CartDetails {
    func updatingLineQuantity(id lineID: String, quantity: Int) -> CartDetails? {
        var updatedLines = lines

        guard let lineIndex = updatedLines.firstIndex(where: { $0.id == lineID }) else {
            return nil
        }

        let line = updatedLines[lineIndex]
        updatedLines[lineIndex] = CartLine(
            id: line.id,
            quantity: quantity,
            cost: line.cost,
            variant: line.variant
        )

        return replacingLines(updatedLines)
    }

    func removingLine(id lineID: String) -> CartDetails? {
        let updatedLines = lines.filter { $0.id != lineID }

        guard updatedLines.count != lines.count else {
            return nil
        }

        return replacingLines(updatedLines)
    }

    private func replacingLines(_ updatedLines: [CartLine]) -> CartDetails {
        CartDetails(
            id: id,
            checkoutUrl: checkoutUrl,
            totalQuantity: updatedLines.reduce(0) { $0 + $1.quantity },
            discountCodes: discountCodes,
            cost: cost,
            lines: updatedLines,
            isLocalEmpty: isLocalEmpty
        )
    }
}
