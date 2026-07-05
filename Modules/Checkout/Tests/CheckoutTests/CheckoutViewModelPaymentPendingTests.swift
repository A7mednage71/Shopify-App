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
            getCustomerDetailsUseCase: GetCustomerDetailsUseCaseMock(result: customerDetails)
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
            getCustomerDetailsUseCase: GetCustomerDetailsUseCaseMock(result: customerDetails)
        )

        await viewModel.load()
        viewModel.selectPaymentMethod(.cashOnDelivery)
        await viewModel.checkoutNow()

        XCTAssertEqual(createOrderMock.capturedPaymentMethodType, .cashOnDelivery)
        XCTAssertEqual(createOrderMock.capturedCart, cart)
        XCTAssertEqual(createOrderMock.capturedCustomerDetails, customerDetails)
    }

    @MainActor
    func testCheckoutNowDelegatesApplePayOrderCreationToUseCase() async {
        let cart = Self.makeCart()
        let customerDetails = Self.makeCustomerDetails()
        let createOrderMock = CreateOrderUseCaseMock()
        let viewModel = CheckoutViewModel(
            getCurrentCartUseCase: GetCurrentCartUseCaseMock(cart: cart),
            createOrderUseCase: createOrderMock,
            getCustomerDetailsUseCase: GetCustomerDetailsUseCaseMock(result: customerDetails)
        )

        await viewModel.load()
        viewModel.selectPaymentMethod(.applePay)
        await viewModel.checkoutNow()

        XCTAssertEqual(createOrderMock.capturedPaymentMethodType, .applePay)
        XCTAssertEqual(createOrderMock.capturedCart, cart)
        XCTAssertEqual(createOrderMock.capturedCustomerDetails, customerDetails)
    }

    func testCreateOrderUseCaseSetsFinancialStatusFromPaymentType() async throws {
        for paymentType in CheckoutPaymentMethodType.allCases {
            let repository = CheckoutRepositoryMock()
            let useCase = CreateOrderUseCase(
                repository: repository,
                paymentStrategyProvider: CheckoutPaymentStrategyProvider()
            )

            _ = try await useCase.execute(
                cart: Self.makeCart(),
                customerDetails: Self.makeCustomerDetails(),
                paymentMethodType: paymentType
            )

            let expectedStatus: OrderFinancialStatus = paymentType == .cashOnDelivery ? .pending : .paid
            XCTAssertEqual(repository.capturedInput?.financialStatus, expectedStatus)
        }
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

    func execute(
        cart: CartDetails,
        customerDetails: CustomerDetails,
        paymentMethodType: CheckoutPaymentMethodType
    ) async throws -> Order {
        capturedCart = cart
        capturedCustomerDetails = customerDetails
        capturedPaymentMethodType = paymentMethodType
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

private final class CheckoutRepositoryMock: CheckoutRepository, @unchecked Sendable {
    private(set) var capturedInput: OrderCreateInput?
    private(set) var didGetCustomerDetails = false

    func createOrder(input: OrderCreateInput) async throws -> Order {
        capturedInput = input
        return Order(
            id: "order-1",
            name: "#1001",
            financialStatus: input.financialStatus.rawValue,
            fulfillmentStatus: "UNFULFILLED",
            totalPrice: "100.00",
            currencyCode: "USD"
        )
    }

    func getCustomerDetails() async throws -> CustomerDetails {
        didGetCustomerDetails = true
        return CheckoutViewModelPaymentPendingTests.makeCustomerDetails()
    }
}
