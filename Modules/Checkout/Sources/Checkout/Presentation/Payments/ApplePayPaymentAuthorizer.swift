import Common
import Foundation
import PassKit

#if os(iOS)
final class ApplePayPaymentAuthorizer: NSObject, CheckoutPaymentAuthorizing {
    private let configurationProvider: () throws -> CheckoutApplePayConfiguration
    private let requestFactory: ApplePayPaymentRequestFactory
    private var continuation: CheckedContinuation<Void, Error>?
    private var controller: PKPaymentAuthorizationController?
    private var didAuthorizePayment = false

    init(
        configurationProvider: @escaping () throws -> CheckoutApplePayConfiguration = { try .live() },
        requestFactory: ApplePayPaymentRequestFactory = ApplePayPaymentRequestFactory()
    ) {
        self.configurationProvider = configurationProvider
        self.requestFactory = requestFactory
    }

    func authorizeApplePay(
        cart: CartDetails,
        customerDetails: CustomerDetails,
        pricing: CheckoutPricing
    ) async throws {
        let configuration = try configurationProvider()

        guard PKPaymentAuthorizationController.canMakePayments(usingNetworks: requestFactory.supportedNetworks) else {
            throw CheckoutPaymentAuthorizationError.applePayUnavailable
        }

        let request = requestFactory.makeRequest(
            customerDetails: customerDetails,
            pricing: pricing,
            configuration: configuration
        )

        let controller = PKPaymentAuthorizationController(paymentRequest: request)
        controller.delegate = self
        self.controller = controller
        didAuthorizePayment = false

        try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<Void, Error>) in
            self.continuation = continuation

            controller.present { [weak self] isPresented in
                guard let self, !isPresented else { return }
                self.resume(with: .failure(CheckoutPaymentAuthorizationError.presentationFailed))
            }
        }
    }

    private func resume(with result: Result<Void, Error>) {
        guard let continuation else { return }
        self.continuation = nil
        controller = nil
        continuation.resume(with: result)
    }
}

extension ApplePayPaymentAuthorizer: @unchecked Sendable {}

extension ApplePayPaymentAuthorizer: PKPaymentAuthorizationControllerDelegate {
    func paymentAuthorizationController(
        _ controller: PKPaymentAuthorizationController,
        didAuthorizePayment payment: PKPayment,
        handler completion: @escaping (PKPaymentAuthorizationResult) -> Void
    ) {
        didAuthorizePayment = true
        completion(PKPaymentAuthorizationResult(status: .success, errors: nil))
    }

    func paymentAuthorizationControllerDidFinish(_ controller: PKPaymentAuthorizationController) {
        controller.dismiss { [weak self] in
            guard let self else { return }
            self.resume(
                with: self.didAuthorizePayment
                    ? .success(())
                    : .failure(CheckoutPaymentAuthorizationError.userCancelled)
            )
        }
    }
}
#else
final class ApplePayPaymentAuthorizer: CheckoutPaymentAuthorizing {
    func authorizeApplePay(
        cart: CartDetails,
        customerDetails: CustomerDetails,
        pricing: CheckoutPricing
    ) async throws {
        throw CheckoutPaymentAuthorizationError.applePayUnavailable
    }
}
#endif
