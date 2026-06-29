import SwiftUI

@MainActor
public final class ProductInfoViewModel: ObservableObject {
    @Published public private(set) var state: ProductInfoViewState = .idle

    private let getProductInfoUseCase: any GetProductInfoUseCaseProtocol

    public convenience init() {
        self.init(getProductInfoUseCase: ProductInfoAssembler.resolveGetProductInfoUseCase())
    }

    init(getProductInfoUseCase: any GetProductInfoUseCaseProtocol) {
        self.getProductInfoUseCase = getProductInfoUseCase
    }

    public func loadProduct(id: String) async {
        state = .loading

        do {
            let product = try await getProductInfoUseCase.execute(productID: id)
            state = .success(product)
        } catch {
            state = .failure(error.localizedDescription)
        }
    }
}
