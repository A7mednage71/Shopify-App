import SwiftUI

struct ProductInfoView: View {
    @StateObject private var viewModel: ProductInfoViewModel
    private let productID: String

    init(productID: String, viewModel: ProductInfoViewModel) {
        self.productID = productID
        self._viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        Group {
            switch viewModel.state {
            case .idle, .loading:
                ProgressView()

            case .success(let product):
                ScrollView {
                    VStack(alignment: .leading, spacing: 12) {
                        Text(product.title)
                            .font(.title)
                            .fontWeight(.semibold)

                        Text(product.description)
                            .font(.body)

                        Text(product.priceRange.minVariantPrice.amount)
                            .font(.headline)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                }

            case .failure(let message):
                Text(message)
                    .foregroundStyle(.red)
            }
        }
        .task {
            await viewModel.loadProduct(id: productID)
        }
    }
}
