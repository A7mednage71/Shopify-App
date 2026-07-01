import Common
import SwiftUI

struct CheckoutView: View {
    @StateObject private var viewModel: CheckoutViewModel

    init(viewModel: CheckoutViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        ZStack {
            AppColors.background
                .ignoresSafeArea()

            content
                .transition(.opacity.combined(with: .scale(scale: 0.98)))
        }
        .navigationTitle(CheckoutText.navigationTitle)
        .checkoutNavigationTitleStyle()
        .task {
            await viewModel.load()
        }
        .animation(.easeInOut(duration: 0.22), value: viewModel.state)
        .animation(.easeInOut(duration: 0.22), value: viewModel.addressState)
    }

    @ViewBuilder
    private var content: some View {
        switch viewModel.state {
        case .idle, .loading:
            CheckoutLoadingView()

        case .success(let cart):
            checkoutContent(cart: cart)

        case .failure(let message):
            CheckoutFailureView(message: message) {
                Task {
                    await viewModel.load()
                }
            }
        }
    }

    private func checkoutContent(cart: CartDetails) -> some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                CheckoutAddressSection(state: viewModel.addressState)

                CheckoutProductsSection(lines: cart.lines)

                CheckoutPaymentMethodSection(
                    methods: viewModel.paymentMethods,
                    selectedType: viewModel.selectedPaymentMethodType,
                    onSelect: viewModel.selectPaymentMethod(_:)
                )

                CheckoutOrderSummarySection(cart: cart)

                CheckoutPrimaryButton(
                    title: CheckoutText.checkoutButtonTitle,
                    action: viewModel.checkoutNow
                )
            }
            .padding(.horizontal, 22)
            .padding(.top, 18)
            .padding(.bottom, 28)
        }
        .background(AppColors.background)
    }
}
