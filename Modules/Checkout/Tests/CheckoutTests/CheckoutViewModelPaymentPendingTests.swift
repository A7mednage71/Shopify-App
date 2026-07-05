import XCTest
@testable import Checkout
import Common

final class CheckoutViewModelPaymentPendingTests: XCTestCase {
    @MainActor
    func testLoadFetchesCustomerDetailsAndSetsAddress() async {
        let defaultAddress = CheckoutAddress(
            title: "Default",
            street: "Street 1",
            city: "Cairo",
            region: "Cairo",
            postalCode: "12345",
            firstName: "John",
            lastName: "Doe"
        )
        let customerDetails = CustomerDetails(
            id: "customer-1",
            email: "john@doe.com",
            phone: "+123456",
            firstName: "John",
            lastName: "Doe",
            defaultAddress: defaultAddress
        )

        let getDetailsMock = GetCustomerDetailsUseCaseMock(result: customerDetails)
        let createOrderMock = CreateOrderUseCaseMock()
        
        let viewModel = CheckoutViewModel(
            cart: CartDetails.empty,
            paymentStrategyProvider: CheckoutPaymentStrategyProvider(),
            createOrderUseCase: createOrderMock,
            getCustomerDetailsUseCase: getDetailsMock
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
    func testCheckoutNowSetsFinancialStatusPendingForCashOnDelivery() async {
        let defaultAddress = CheckoutAddress(
            title: "Default",
            street: "Street 1",
            city: "Cairo",
            region: "Cairo",
            postalCode: "12345",
            firstName: "John",
            lastName: "Doe"
        )
        let customerDetails = CustomerDetails(
            id: "customer-1",
            email: "john@doe.com",
            phone: "+123456",
            firstName: "John",
            lastName: "Doe",
            defaultAddress: defaultAddress
        )

        let getDetailsMock = GetCustomerDetailsUseCaseMock(result: customerDetails)
        let createOrderMock = CreateOrderUseCaseMock()
        
        let viewModel = CheckoutViewModel(
            cart: CartDetails.empty,
            paymentStrategyProvider: CheckoutPaymentStrategyProvider(),
            createOrderUseCase: createOrderMock,
            getCustomerDetailsUseCase: getDetailsMock
        )

        await viewModel.load()
        viewModel.selectPaymentMethod(.cashOnDelivery)
        await viewModel.checkoutNow()

        XCTAssertEqual(createOrderMock.capturedInput?.financialStatus, .pending)
    }

    @MainActor
    func testCheckoutNowSetsFinancialStatusPaidForApplePayAndCard() async {
        let defaultAddress = CheckoutAddress(
            title: "Default",
            street: "Street 1",
            city: "Cairo",
            region: "Cairo",
            postalCode: "12345",
            firstName: "John",
            lastName: "Doe"
        )
        let customerDetails = CustomerDetails(
            id: "customer-1",
            email: "john@doe.com",
            phone: "+123456",
            firstName: "John",
            lastName: "Doe",
            defaultAddress: defaultAddress
        )

        for paymentType in [CheckoutPaymentMethodType.card, .applePay] {
            let getDetailsMock = GetCustomerDetailsUseCaseMock(result: customerDetails)
            let createOrderMock = CreateOrderUseCaseMock()
            
            let viewModel = CheckoutViewModel(
                cart: CartDetails.empty,
                paymentStrategyProvider: CheckoutPaymentStrategyProvider(),
                createOrderUseCase: createOrderMock,
                getCustomerDetailsUseCase: getDetailsMock
            )

            await viewModel.load()
            viewModel.selectPaymentMethod(paymentType)
            await viewModel.checkoutNow()

            XCTAssertEqual(createOrderMock.capturedInput?.financialStatus, .paid)
        }
    }
}

private final class GetCustomerDetailsUseCaseMock: GetCustomerDetailsUseCaseProtocol, @unchecked Sendable {
    let result: CustomerDetails

    init(result: CustomerDetails) {
        self.result = result
    }

    func execute() async throws -> CustomerDetails {
        return result
    }
}

private final class CreateOrderUseCaseMock: CreateOrderUseCaseProtocol, @unchecked Sendable {
    private(set) var capturedInput: OrderCreateInput?

    func execute(input: OrderCreateInput) async throws -> Order {
        capturedInput = input
        return Order(
            id: "order-1",
            name: "#1001",
            financialStatus: input.financialStatus.rawValue,
            fulfillmentStatus: "UNFULFILLED",
            totalPrice: "0.0",
            currencyCode: "USD"
        )
    }
}
