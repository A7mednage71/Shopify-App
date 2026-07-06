import Common

public struct CheckoutLoadedState: Equatable {
    public let cart: CartDetails
    public let customerDetails: CustomerDetails

    public init(cart: CartDetails, customerDetails: CustomerDetails) {
        self.cart = cart
        self.customerDetails = customerDetails
    }
}

public enum CheckoutViewState: Equatable {
    case idle
    case loading
    case success(CheckoutLoadedState)
    case failure(String)

    var loadedState: CheckoutLoadedState? {
        if case let .success(loadedState) = self {
            return loadedState
        }

        return nil
    }
}

public enum CheckoutAddressViewState: Equatable {
    case loading
    case empty
    case success(CheckoutAddress)
    case failure(String)
}
