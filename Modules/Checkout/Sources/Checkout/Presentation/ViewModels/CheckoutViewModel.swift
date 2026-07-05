import Common
import Foundation

@MainActor
public final class CheckoutViewModel: ObservableObject {
    @Published public private(set) var state: CheckoutViewState = .idle
    @Published public private(set) var addressState: CheckoutAddressViewState = .loading
    @Published public private(set) var paymentMethods: [CheckoutPaymentMethod]
    @Published public private(set) var selectedPaymentMethodType: CheckoutPaymentMethodType
    @Published public var checkoutErrorMessage: String?
    @Published var orderConfirmationRoute: CheckoutOrderConfirmationRoute?

    // Loading indicator
    @Published public var isLoading = false

    // Payment Method binding enum
    public enum PaymentMethod: Sendable {
        case card
        case applePay
        case cashOnDelivery
    }
    @Published public var selectedPaymentMethod: PaymentMethod = .card

    private let cart: CartDetails
    private let paymentStrategyProvider: CheckoutPaymentStrategyProvider
    
    // New Use Cases
    private let createOrderUseCase: any CreateOrderUseCaseProtocol
    private let getCustomerDetailsUseCase: any GetCustomerDetailsUseCaseProtocol

    private var selectedAddress: CheckoutAddress?
    private var customerId: String?
    private var customerEmail: String?
    private var customerPhone: String?

    init(
        cart: CartDetails,
        paymentStrategyProvider: CheckoutPaymentStrategyProvider,
        createOrderUseCase: any CreateOrderUseCaseProtocol,
        getCustomerDetailsUseCase: any GetCustomerDetailsUseCaseProtocol
    ) {
        self.cart = cart
        self.paymentStrategyProvider = paymentStrategyProvider
        self.createOrderUseCase = createOrderUseCase
        self.getCustomerDetailsUseCase = getCustomerDetailsUseCase
        self.paymentMethods = paymentStrategyProvider.methods
        self.selectedPaymentMethodType = paymentStrategyProvider.methods.first?.type ?? .card
        
        // Initial binding setup
        self.bindPaymentMethodType(self.selectedPaymentMethodType)
    }

    public var selectedPaymentMethodModel: CheckoutPaymentMethod? {
        paymentMethods.first { $0.type == selectedPaymentMethodType }
    }

    public var isCheckoutButtonDisabled: Bool {
        selectedAddress == nil || isLoading
    }

    public func load() async {
        state = .success(cart)
        addressState = .loading
        checkoutErrorMessage = nil

        do {
            let customerDetails = try await getCustomerDetailsUseCase.execute()
            self.customerId = customerDetails.id
            self.customerEmail = customerDetails.email
            self.customerPhone = customerDetails.phone
            
            if let defaultAddress = customerDetails.defaultAddress {
                self.selectedAddress = defaultAddress
                self.addressState = .success(defaultAddress)
            } else {
                self.selectedAddress = nil
                self.addressState = .empty
            }
        } catch {
            self.selectedAddress = nil
            self.addressState = .empty
            self.checkoutErrorMessage = error.localizedDescription
        }
    }

    public func selectPaymentMethod(_ type: CheckoutPaymentMethodType) {
        selectedPaymentMethodType = type
        bindPaymentMethodType(type)
        checkoutErrorMessage = nil
    }

    private func bindPaymentMethodType(_ type: CheckoutPaymentMethodType) {
        switch type {
        case .card:
            selectedPaymentMethod = .card
        case .applePay:
            selectedPaymentMethod = .applePay
        case .cashOnDelivery:
            selectedPaymentMethod = .cashOnDelivery
        }
    }

    public func checkoutNow() async {
        guard case let .success(cart) = state, let address = selectedAddress else {
            if selectedAddress == nil {
                self.checkoutErrorMessage = CheckoutText.addressEmptyTitle
            }
            return
        }

        isLoading = true
        checkoutErrorMessage = nil
        orderConfirmationRoute = nil

        let financialStatus: OrderFinancialStatus = (selectedPaymentMethod == .cashOnDelivery) ? .pending : .paid

        // Cart Discount mapping rules
        var discountAmount: Decimal? = nil
        var discountCode: String? = nil
        if let activeDiscount = cart.discountCodes.first(where: { $0.applicable }) {
            let subtotal = Decimal(string: cart.cost.subtotalAmount.amount.replacingOccurrences(of: ",", with: "")) ?? 0
            let total = Decimal(string: cart.cost.totalAmount.amount.replacingOccurrences(of: ",", with: "")) ?? 0
            let difference = subtotal - total
            if difference > 0 {
                discountAmount = difference
                discountCode = activeDiscount.code
            }
        }

        let shippingAddress = ShippingAddressInput(
            firstName: address.firstName,
            lastName: address.lastName ?? "Customer",
            company: address.company,
            address1: address.street,
            address2: address.street2,
            city: address.city,
            provinceCode: address.region,
            // Defaulting to "EG" (Egypt) since the application primarily targets local customers and address countryCode might be empty.
            countryCode: address.countryCode ?? "EG",
            zip: address.postalCode,
            phone: address.phone
        )

        let lineItems = cart.lines.compactMap { line -> LineItemInput? in
            guard let variantId = line.variant?.id else { return nil }
            return LineItemInput(variantId: variantId, quantity: line.quantity)
        }

        let totalAmount = Decimal(string: cart.cost.totalAmount.amount.replacingOccurrences(of: ",", with: "")) ?? 0

        let input = OrderCreateInput(
            currency: cart.cost.subtotalAmount.currencyCode.isEmpty ? "USD" : cart.cost.subtotalAmount.currencyCode,
            email: customerEmail,
            phone: customerPhone,
            customerId: customerId,
            lineItems: lineItems,
            shippingAddress: shippingAddress,
            shippingLine: nil,
            discountAmount: discountAmount,
            discountCode: discountCode,
            financialStatus: financialStatus,
            totalAmount: totalAmount
        )

        do {
            _ = try await createOrderUseCase.execute(input: input)
            
            let confirmationRoute = CheckoutOrderConfirmationRoute(
                cart: cart,
                paymentMethodTitle: selectedPaymentMethodModel?.title
            )
            
            self.orderConfirmationRoute = confirmationRoute
        } catch {
            self.checkoutErrorMessage = error.localizedDescription
        }
        isLoading = false
    }

    func dismissOrderConfirmation() {
        orderConfirmationRoute = nil
    }
}

public struct CheckoutOrderConfirmationRoute: Identifiable {
    public let id = UUID()
    let cart: CartDetails
    let paymentMethodTitle: String?
}
