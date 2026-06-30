import Common
import SwiftUI

@MainActor
public final class ProductInfoViewModel: ObservableObject {
    @Published public private(set) var state: ProductInfoViewState = .idle
    @Published public private(set) var addToCartState: ProductInfoAddToCartState = .idle

    private let getProductInfoUseCase: any GetProductInfoUseCaseProtocol
    private let addItemToCartUseCase: any AddItemToCartUseCaseProtocol

    init(
        getProductInfoUseCase: any GetProductInfoUseCaseProtocol,
        addItemToCartUseCase: any AddItemToCartUseCaseProtocol
    ) {
        self.getProductInfoUseCase = getProductInfoUseCase
        self.addItemToCartUseCase = addItemToCartUseCase
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

    public func addToCart(variant: ProductVariant?, quantity: Int) async {
        guard let variant else {
            addToCartState = .failure("Please select an available variant.")
            return
        }

        addToCartState = .loading

        do {
            let cart = try await addItemToCartUseCase.execute(
                input: AddCartItemInput(
                    variantID: variant.id,
                    quantity: quantity,
                    availableQuantity: variant.quantityAvailable
                )
            )

            addToCartState = .success(cart)
        } catch {
            addToCartState = .failure(error.localizedDescription)
        }
    }
}
