import XCTest
@testable import Checkout
import Common

final class CheckoutViewModelPaymentPendingTests: XCTestCase {
    func testCompleteOrderSetsPaymentPendingTrueForCashOnDelivery() async {
        let recorder = CompleteDraftOrderUseCaseMock()
        let viewModel = makeViewModel(completeDraftOrderUseCase: recorder)

        viewModel.selectPaymentMethod(.cashOnDelivery)
        await viewModel.completeOrder(draftOrderId: "draft-order-1")

        XCTAssertEqual(recorder.capturedPaymentPending, true)
    }

    func testCompleteOrderSetsPaymentPendingFalseForCardAndApplePay() async {
        for method in [CheckoutPaymentMethodType.card, .applePay] {
            let recorder = CompleteDraftOrderUseCaseMock()
            let viewModel = makeViewModel(completeDraftOrderUseCase: recorder)

            viewModel.selectPaymentMethod(method)
            await viewModel.completeOrder(draftOrderId: "draft-order-\(method.rawValue)")

            XCTAssertEqual(recorder.capturedPaymentPending, false)
        }
    }

    private func makeViewModel(
        completeDraftOrderUseCase: CompleteDraftOrderUseCaseMock
    ) -> CheckoutViewModel {
        CheckoutViewModel(
            cart: CartDetails.empty,
            paymentStrategyProvider: CheckoutPaymentStrategyProvider(),
            performCheckoutUseCase: PerformCheckoutUseCaseMock(),
            createDraftOrderUseCase: CreateDraftOrderUseCaseMock(),
            applyDraftOrderDiscountUseCase: ApplyDraftOrderDiscountUseCaseMock(),
            completeDraftOrderUseCase: completeDraftOrderUseCase
        )
    }
}

private final class CompleteDraftOrderUseCaseMock: CompleteDraftOrderUseCaseProtocol, @unchecked Sendable {
    private(set) var capturedPaymentPending: Bool?

    func execute(draftOrderId: String, paymentPending: Bool) async throws -> CompletedOrder {
        capturedPaymentPending = paymentPending
        return CompletedOrder(
            id: draftOrderId,
            status: paymentPending ? "pending" : "paid",
            orderId: nil,
            orderName: nil,
            createdAt: nil,
            totalAmount: nil,
            currencyCode: nil,
            email: nil
        )
    }
}

private final class PerformCheckoutUseCaseMock: PerformCheckoutUseCaseProtocol, @unchecked Sendable {
    func execute(paymentMethodType: CheckoutPaymentMethodType, cart: CartDetails) async throws -> CheckoutPaymentAction {
        .none
    }
}

private final class CreateDraftOrderUseCaseMock: CreateDraftOrderUseCaseProtocol, @unchecked Sendable {
    func execute(input: DraftOrderCreateInput) async throws -> DraftOrder {
        DraftOrder(
            id: "draft-1",
            name: "Draft Order",
            status: "open",
            subtotalPrice: nil,
            totalPrice: nil,
            totalTax: nil,
            currencyCode: "USD",
            lineItems: []
        )
    }
}

private final class ApplyDraftOrderDiscountUseCaseMock: ApplyDraftOrderDiscountUseCaseProtocol, @unchecked Sendable {
    func execute(draftOrderId: String, discount: DiscountInput) async throws -> DraftOrder {
        DraftOrder(
            id: draftOrderId,
            name: "Draft Order",
            status: "open",
            subtotalPrice: nil,
            totalPrice: nil,
            totalTax: nil,
            currencyCode: "USD",
            lineItems: []
        )
    }
}
