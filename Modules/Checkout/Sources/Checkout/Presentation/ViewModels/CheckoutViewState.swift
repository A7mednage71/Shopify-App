import Common

public enum CheckoutViewState: Equatable {
    case idle
    case loading
    case success(CartDetails)
    case failure(String)
}

public enum CheckoutAddressViewState: Equatable {
    case loading
    case empty
    case success(CheckoutAddress)
    case failure(String)
}
