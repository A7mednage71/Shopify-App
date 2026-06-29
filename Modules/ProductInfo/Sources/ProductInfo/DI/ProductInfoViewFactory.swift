import SwiftUI

public enum ProductInfoViewFactory {
    @MainActor
    public static func makeProductInfoView(productID: String) -> some View {
        let viewModelFactory = ProductInfoAssembler.resolveViewModelFactory()

        return ProductInfoView(
            productID: productID,
            viewModel: viewModelFactory.makeViewModel()
        )
    }
}
