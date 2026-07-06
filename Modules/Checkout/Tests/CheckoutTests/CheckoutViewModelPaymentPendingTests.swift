import XCTest
@testable import Checkout
import Common

final class CheckoutViewModelPaymentPendingTests: XCTestCase {
    @MainActor
    func testLoadFetchesCustomerDetailsAndSetsAddress() async {
        let customerDetails = Self.makeCustomerDetails()
        let viewModel = CheckoutViewModel(
            getCurrentCartUseCase: GetCurrentCartUseCaseMock(cart: CartDetails.empty),
            createOrderUseCase: CreateOrderUseCaseMock(),
            getCustomerDetailsUseCase: GetCustomerDetailsUseCaseMock(result: customerDetails),
            checkoutPricingUseCase: CheckoutPricingUseCaseMock(),
            paymentAuthorizer: CheckoutPaymentAuthorizerMock()
        )

        await viewModel.load()

        if case let .success(loadedAddress) = viewModel.addressState {
            XCTAssertEqual(loadedAddress.street, "Street 1")
            XCTAssertEqual(loadedAddress.city, "Cairo")
        } else {
            XCTFail("Expected addressState to be success")
        }
    }

    @MainActor
    func testCheckoutNowDelegatesCashOnDeliveryOrderCreationToUseCase() async {
        let cart = Self.makeCart()
        let customerDetails = Self.makeCustomerDetails()
        let createOrderMock = CreateOrderUseCaseMock()
        let viewModel = CheckoutViewModel(
            getCurrentCartUseCase: GetCurrentCartUseCaseMock(cart: cart),
            createOrderUseCase: createOrderMock,
            getCustomerDetailsUseCase: GetCustomerDetailsUseCaseMock(result: customerDetails),
            checkoutPricingUseCase: CheckoutPricingUseCaseMock(),
            paymentAuthorizer: CheckoutPaymentAuthorizerMock()
        )

        await viewModel.load()
        viewModel.selectPaymentMethod(.cashOnDelivery)
        await viewModel.checkoutNow()

        XCTAssertEqual(createOrderMock.capturedPaymentMethodType, .cashOnDelivery)
        XCTAssertEqual(createOrderMock.capturedCart, cart)
        XCTAssertEqual(createOrderMock.capturedCustomerDetails, customerDetails)
    }

    @MainActor
    func testCheckoutNowAuthorizesApplePayBeforeOrderCreation() async {
        let cart = Self.makeCart()
        let customerDetails = Self.makeCustomerDetails()
        let createOrderMock = CreateOrderUseCaseMock()
        let paymentAuthorizer = CheckoutPaymentAuthorizerMock()
        paymentAuthorizer.onAuthorize = {
            XCTAssertNil(createOrderMock.capturedPaymentMethodType)
        }
        let viewModel = CheckoutViewModel(
            getCurrentCartUseCase: GetCurrentCartUseCaseMock(cart: cart),
            createOrderUseCase: createOrderMock,
            getCustomerDetailsUseCase: GetCustomerDetailsUseCaseMock(result: customerDetails),
            checkoutPricingUseCase: CheckoutPricingUseCaseMock(),
            paymentAuthorizer: paymentAuthorizer
        )

        await viewModel.load()
        viewModel.selectPaymentMethod(.applePay)
        await viewModel.checkoutNow()

        XCTAssertTrue(paymentAuthorizer.didAuthorizeApplePay)
        XCTAssertEqual(createOrderMock.capturedPaymentMethodType, .applePay)
        XCTAssertEqual(createOrderMock.capturedCart, cart)
        XCTAssertEqual(createOrderMock.capturedCustomerDetails, customerDetails)
    }

    @MainActor
    func testCheckoutNowCancellingApplePayDoesNotCreateOrderOrShowError() async {
        let createOrderMock = CreateOrderUseCaseMock()
        let paymentAuthorizer = CheckoutPaymentAuthorizerMock(result: .failure(CheckoutPaymentAuthorizationError.userCancelled))
        let viewModel = CheckoutViewModel(
            getCurrentCartUseCase: GetCurrentCartUseCaseMock(cart: Self.makeCart()),
            createOrderUseCase: createOrderMock,
            getCustomerDetailsUseCase: GetCustomerDetailsUseCaseMock(result: Self.makeCustomerDetails()),
            checkoutPricingUseCase: CheckoutPricingUseCaseMock(),
            paymentAuthorizer: paymentAuthorizer
        )

        await viewModel.load()
        viewModel.selectPaymentMethod(.applePay)
        await viewModel.checkoutNow()

        XCTAssertTrue(paymentAuthorizer.didAuthorizeApplePay)
        XCTAssertNil(createOrderMock.capturedPaymentMethodType)
        XCTAssertNil(viewModel.orderPlacement.errorMessage)
        XCTAssertFalse(viewModel.orderPlacement.isPlacingOrder)
    }

    @MainActor
    func testCheckoutNowApplePayFailureShowsError() async {
        let createOrderMock = CreateOrderUseCaseMock()
        let paymentAuthorizer = CheckoutPaymentAuthorizerMock(result: .failure(CheckoutPaymentAuthorizationError.applePayUnavailable))
        let viewModel = CheckoutViewModel(
            getCurrentCartUseCase: GetCurrentCartUseCaseMock(cart: Self.makeCart()),
            createOrderUseCase: createOrderMock,
            getCustomerDetailsUseCase: GetCustomerDetailsUseCaseMock(result: Self.makeCustomerDetails()),
            checkoutPricingUseCase: CheckoutPricingUseCaseMock(),
            paymentAuthorizer: paymentAuthorizer
        )

        await viewModel.load()
        viewModel.selectPaymentMethod(.applePay)
        await viewModel.checkoutNow()

        XCTAssertNil(createOrderMock.capturedPaymentMethodType)
        XCTAssertEqual(viewModel.orderPlacement.errorMessage, "Apple Pay is not available on this device.")
        XCTAssertFalse(viewModel.orderPlacement.isPlacingOrder)
    }

    @MainActor
    func testCheckoutNowCashOnDeliverySkipsPaymentAuthorizer() async {
        let createOrderMock = CreateOrderUseCaseMock()
        let paymentAuthorizer = CheckoutPaymentAuthorizerMock()
        let viewModel = CheckoutViewModel(
            getCurrentCartUseCase: GetCurrentCartUseCaseMock(cart: Self.makeCart()),
            createOrderUseCase: createOrderMock,
            getCustomerDetailsUseCase: GetCustomerDetailsUseCaseMock(result: Self.makeCustomerDetails()),
            checkoutPricingUseCase: CheckoutPricingUseCaseMock(),
            paymentAuthorizer: paymentAuthorizer
        )

        await viewModel.load()
        viewModel.selectPaymentMethod(.cashOnDelivery)
        await viewModel.checkoutNow()

        XCTAssertFalse(paymentAuthorizer.didAuthorizeApplePay)
        XCTAssertEqual(createOrderMock.capturedPaymentMethodType, .cashOnDelivery)
    }

    func testCreateOrderUseCaseSetsFinancialStatusFromPaymentType() async throws {
        for paymentType in CheckoutPaymentMethodType.allCases {
            let repository = CheckoutRepositoryMock()
            let createCartUseCase = CreateCartUseCaseMock()
            let useCase = CreateOrderUseCase(
                repository: repository,
                paymentStrategyProvider: CheckoutPaymentStrategyProvider(),
                checkoutPricingUseCase: CheckoutPricingUseCase(repository: repository),
                createCartUseCase: createCartUseCase
            )

            _ = try await useCase.execute(
                cart: Self.makeCart(),
                customerDetails: Self.makeCustomerDetails(),
                paymentMethodType: paymentType,
                shippingMethod: .standard
            )

            let expectedStatus: OrderFinancialStatus = paymentType == .cashOnDelivery ? .pending : .paid
            XCTAssertEqual(repository.capturedInput?.financialStatus, expectedStatus)
            XCTAssertEqual(createCartUseCase.executeCallCount, 1)
        }
    }

    func testCreateOrderUseCaseResetsCartAfterOrderCreationSucceeds() async throws {
        let repository = CheckoutRepositoryMock()
        let createCartUseCase = CreateCartUseCaseMock()
        let useCase = CreateOrderUseCase(
            repository: repository,
            paymentStrategyProvider: CheckoutPaymentStrategyProvider(),
            checkoutPricingUseCase: CheckoutPricingUseCase(repository: repository),
            createCartUseCase: createCartUseCase
        )

        _ = try await useCase.execute(
            cart: Self.makeCart(),
            customerDetails: Self.makeCustomerDetails(),
            paymentMethodType: .cashOnDelivery,
            shippingMethod: .standard
        )

        XCTAssertEqual(createCartUseCase.executeCallCount, 1)
    }

    func testCreateOrderUseCaseDoesNotResetCartWhenOrderCreationFails() async {
        let repository = CheckoutRepositoryMock(createOrderResult: .failure(TestError.expected))
        let createCartUseCase = CreateCartUseCaseMock()
        let useCase = CreateOrderUseCase(
            repository: repository,
            paymentStrategyProvider: CheckoutPaymentStrategyProvider(),
            checkoutPricingUseCase: CheckoutPricingUseCase(repository: repository),
            createCartUseCase: createCartUseCase
        )

        do {
            _ = try await useCase.execute(
                cart: Self.makeCart(),
                customerDetails: Self.makeCustomerDetails(),
                paymentMethodType: .cashOnDelivery,
                shippingMethod: .standard
            )
            XCTFail("Expected order creation to fail")
        } catch {
            XCTAssertEqual(error as? TestError, .expected)
        }

        XCTAssertEqual(createCartUseCase.executeCallCount, 0)
    }

    func testCreateOrderUseCaseKeepsOrderSuccessWhenCartResetFails() async throws {
        let repository = CheckoutRepositoryMock()
        let createCartUseCase = CreateCartUseCaseMock(result: .failure(TestError.expected))
        let useCase = CreateOrderUseCase(
            repository: repository,
            paymentStrategyProvider: CheckoutPaymentStrategyProvider(),
            checkoutPricingUseCase: CheckoutPricingUseCase(repository: repository),
            createCartUseCase: createCartUseCase
        )

        let order = try await useCase.execute(
            cart: Self.makeCart(),
            customerDetails: Self.makeCustomerDetails(),
            paymentMethodType: .cashOnDelivery,
            shippingMethod: .standard
        )

        XCTAssertEqual(order.id, "order-1")
        XCTAssertEqual(createCartUseCase.executeCallCount, 1)
    }

    func testPaymentStrategyProviderExposesAvailablePaymentMethods() {
        let provider = CheckoutPaymentStrategyProvider()

        XCTAssertEqual(provider.paymentMethods, [.applePay, .cashOnDelivery])
    }

    func testGetCustomerDetailsUseCaseDelegatesToRepository() async throws {
        let repository = CheckoutRepositoryMock()
        let useCase = GetCustomerDetailsUseCase(repository: repository)

        _ = try await useCase.execute()

        XCTAssertTrue(repository.didGetCustomerDetails)
    }

    func testDummyCustomerAccessTokenDataSourceProvidesToken() async throws {
        let dataSource = DummyCustomerAccessTokenDataSource(token: "test-token")

        let token = try await dataSource.customerAccessToken()

        XCTAssertEqual(token, "test-token")
    }

    fileprivate static func makeCustomerDetails() -> CustomerDetails {
        let defaultAddress = CheckoutAddress(
            title: "Default",
            street: "Street 1",
            city: "Cairo",
            region: "Cairo",
            postalCode: "12345",
            firstName: "John",
            lastName: "Doe",
            countryCode: "EG"
        )

        return CustomerDetails(
            id: "customer-1",
            email: "john@doe.com",
            phone: "+123456",
            firstName: "John",
            lastName: "Doe",
            defaultAddress: defaultAddress
        )
    }

    fileprivate static func makeCart() -> CartDetails {
        CartDetails(
            id: "cart-1",
            checkoutUrl: "https://example.com/checkout",
            totalQuantity: 1,
            discountCodes: [],
            cost: CartCost(
                subtotalAmount: CartMoney(amount: "100.00", currencyCode: "USD"),
                totalAmount: CartMoney(amount: "100.00", currencyCode: "USD"),
                totalTaxAmount: nil,
                checkoutChargeAmount: nil
            ),
            lines: [
                CartLine(
                    id: "line-1",
                    quantity: 1,
                    cost: nil,
                    variant: CartProductVariant(
                        id: "variant-1",
                        title: "Default",
                        price: nil,
                        compareAtPrice: nil,
                        availableForSale: true,
                        quantityAvailable: 1,
                        selectedOptions: [],
                        image: nil,
                        product: nil
                    )
                )
            ]
        )
    }
}

private final class GetCurrentCartUseCaseMock: GetCurrentCartUseCaseProtocol, @unchecked Sendable {
    let cart: CartDetails

    init(cart: CartDetails) {
        self.cart = cart
    }

    func execute() async throws -> CartDetails {
        cart
    }
}

private final class GetCustomerDetailsUseCaseMock: GetCustomerDetailsUseCaseProtocol, @unchecked Sendable {
    let result: CustomerDetails

    init(result: CustomerDetails) {
        self.result = result
    }

    func execute() async throws -> CustomerDetails {
        result
    }
}

private final class CreateOrderUseCaseMock: CreateOrderUseCaseProtocol, @unchecked Sendable {
    private(set) var capturedCart: CartDetails?
    private(set) var capturedCustomerDetails: CustomerDetails?
    private(set) var capturedPaymentMethodType: CheckoutPaymentMethodType?
    private(set) var capturedShippingMethod: CheckoutShippingMethod?

    func execute(
        cart: CartDetails,
        customerDetails: CustomerDetails,
        paymentMethodType: CheckoutPaymentMethodType,
        shippingMethod: CheckoutShippingMethod
    ) async throws -> Order {
        capturedCart = cart
        capturedCustomerDetails = customerDetails
        capturedPaymentMethodType = paymentMethodType
        capturedShippingMethod = shippingMethod
        return Order(
            id: "order-1",
            name: "#1001",
            financialStatus: paymentMethodType == .cashOnDelivery ? "PENDING" : "PAID",
            fulfillmentStatus: "UNFULFILLED",
            totalPrice: "100.00",
            currencyCode: "USD"
        )
    }
}

private final class CheckoutPaymentAuthorizerMock: CheckoutPaymentAuthorizing {
    private let result: Result<Void, Error>
    private(set) var didAuthorizeApplePay = false
    var onAuthorize: (() -> Void)?

    init(result: Result<Void, Error> = .success(())) {
        self.result = result
    }

    func authorizeApplePay(
        cart: CartDetails,
        customerDetails: CustomerDetails,
        pricing: CheckoutPricing
    ) async throws {
        didAuthorizeApplePay = true
        onAuthorize?()
        try result.get()
    }
}

private final class CreateCartUseCaseMock: CreateCartUseCaseProtocol, @unchecked Sendable {
    private let result: Result<CartDetails, Error>
    private(set) var executeCallCount = 0

    init(result: Result<CartDetails, Error> = .success(.empty)) {
        self.result = result
    }

    func execute() async throws -> CartDetails {
        executeCallCount += 1
        return try result.get()
    }
}

private final class CheckoutRepositoryMock: CheckoutRepository, @unchecked Sendable {
    private let createOrderResult: Result<Order, Error>
    private(set) var capturedInput: OrderCreateInput?
    private(set) var didGetCustomerDetails = false

    init(createOrderResult: Result<Order, Error>? = nil) {
        self.createOrderResult = createOrderResult ?? .success(Self.defaultOrder())
    }

    func createOrder(input: OrderCreateInput) async throws -> Order {
        capturedInput = input
        return try createOrderResult.get()
    }

    func getCustomerDetails() async throws -> CustomerDetails {
        didGetCustomerDetails = true
        return CheckoutViewModelPaymentPendingTests.makeCustomerDetails()
    }

    func validateDiscountCode(code: String) async throws -> ValidatedDiscountCode? {
        nil
    }

    private static func defaultOrder() -> Order {
        Order(
            id: "order-1",
            name: "#1001",
            financialStatus: "PAID",
            fulfillmentStatus: "UNFULFILLED",
            totalPrice: "100.00",
            currencyCode: "USD"
        )
    }
}

private enum TestError: Error, Equatable {
    case expected
}

private struct CheckoutPricingUseCaseMock: CheckoutPricingUseCaseProtocol {
    func execute(
        cart: CartDetails,
        shippingMethod: CheckoutShippingMethod
    ) async -> CheckoutPricing {
        pricing(cart: cart, shippingMethod: shippingMethod)
    }

    func executeForOrder(
        cart: CartDetails,
        shippingMethod: CheckoutShippingMethod
    ) async throws -> CheckoutPricing {
        pricing(cart: cart, shippingMethod: shippingMethod)
    }

    private func pricing(
        cart: CartDetails,
        shippingMethod: CheckoutShippingMethod
    ) -> CheckoutPricing {
        CheckoutPricing(
            currencyCode: cart.cost.subtotalAmount.currencyCode,
            subtotal: cart.cost.subtotalAmount.checkoutDecimalValue,
            shippingMethod: shippingMethod,
            discountState: .none,
            discountAmount: 0,
            orderDiscount: nil
        )
    }
}
