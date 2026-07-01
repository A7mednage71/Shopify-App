import Common
import SwiftUI

struct CartDetailsView: View {
    @StateObject private var viewModel: CartViewModel
    private let checkoutDestination: () -> AnyView

    init(
        viewModel: CartViewModel,
        checkoutDestination: @escaping () -> AnyView
    ) {
        self._viewModel = StateObject(wrappedValue: viewModel)
        self.checkoutDestination = checkoutDestination
    }

    var body: some View {
        ZStack {
            AppColors.background
                .ignoresSafeArea()

            content
                .transition(.opacity.combined(with: .scale(scale: 0.98)))
        }
        .navigationTitle(CartText.navigationTitle)
        .cartNavigationTitleStyle()
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
                    discountCodeText: viewModel.discountCodeText,
                    appliedDiscountCode: viewModel.appliedDiscountCode,
                    isApplyingDiscountCode: viewModel.isApplyingDiscountCode,
                    discountCodeErrorMessage: viewModel.discountCodeErrorMessage,
                    onIncrement: viewModel.increment(lineID:),
                    onDecrement: viewModel.decrement(lineID:),
                    onRemove: viewModel.remove(lineID:),
                    onDiscountCodeChange: viewModel.updateDiscountCodeText(_:),
                    onApplyDiscountCode: {
                        Task {
                            await viewModel.applyDiscountCode()
                        }
                    },
                    onRemoveDiscountCode: {
                        Task {
                            await viewModel.removeDiscountCode()
                        }
                    },
                    checkoutDestination: checkoutDestination
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
