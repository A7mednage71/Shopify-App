import Common
import SwiftUI

struct CartDetailsView: View {
    @StateObject private var viewModel: CartViewModel

    init(viewModel: CartViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        NavigationView {
            ZStack {
                AppColors.background
                    .ignoresSafeArea()

                content
                    .transition(.opacity.combined(with: .scale(scale: 0.98)))
            }
            .navigationTitle(CartText.navigationTitle)
            .cartNavigationTitleStyle()
        }
        .cartNavigationContainerStyle()
        .task {
            await viewModel.loadCart()
        }
        .animation(.easeInOut(duration: 0.22), value: viewModel.state)
    }

    @ViewBuilder
    private var content: some View {
        switch viewModel.state {
        case .idle, .loading:
            CartLoadingView()

        case .success(let cart):
            if cart.isEmpty {
                CartEmptyView()
            } else {
                CartLoadedView(
                    cart: cart,
                    errorMessage: viewModel.errorMessage,
                    onIncrement: viewModel.increment(lineID:),
                    onDecrement: viewModel.decrement(lineID:),
                    onRemove: viewModel.remove(lineID:)
                )
            }

        case .failure(let message):
            CartFailureView(message: message) {
                Task {
                    await viewModel.loadCart()
                }
            }
        }
    }
}
