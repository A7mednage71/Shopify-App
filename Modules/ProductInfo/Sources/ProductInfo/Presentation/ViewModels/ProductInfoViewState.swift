import Common

public enum ProductInfoViewState: Equatable, Sendable {
    case idle
    case loading
    case success(ProductDetails)
    case failure(String)
}

public enum ProductInfoAddToCartState: Equatable, Sendable {
    case idle
    case loading
    case success(CartDetails)
    case failure(String)
}
