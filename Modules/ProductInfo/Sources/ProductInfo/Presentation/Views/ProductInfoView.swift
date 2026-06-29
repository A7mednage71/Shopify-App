import SwiftUI

struct ProductInfoView: View {
    @StateObject private var viewModel: ProductInfoViewModel
    private let productID: String

    init(productID: String, viewModel: ProductInfoViewModel) {
        self.productID = productID
        self._viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        NavigationView {
            content
                .navigationTitle("Product Details")
                .productNavigationTitleStyle()
        }
        .productNavigationContainerStyle()
        .task {
            await viewModel.loadProduct(id: productID)
        }
    }

    @ViewBuilder
    private var content: some View {
        Group {
            switch viewModel.state {
            case .idle, .loading:
                ProductInfoLoadingView()

            case .success(let product):
                ProductInfoContentView(product: product)

            case .failure(let message):
                ProductInfoErrorView(message: message) {
                    Task {
                        await viewModel.loadProduct(id: productID)
                    }
                }
            }
        }
    }
}

private extension View {
    func productNavigationTitleStyle() -> some View {
        navigationBarTitleDisplayMode(.inline)
    }

    func productNavigationContainerStyle() -> some View {
        navigationViewStyle(.stack)
    }
}
