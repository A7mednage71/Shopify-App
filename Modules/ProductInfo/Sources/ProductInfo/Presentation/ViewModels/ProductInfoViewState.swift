public enum ProductInfoViewState: Equatable, Sendable {
    case idle
    case loading
    case success(ProductDetails)
    case failure(String)
}
