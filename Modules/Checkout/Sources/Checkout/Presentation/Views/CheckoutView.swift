import Common
import SwiftUI

struct CheckoutView: View {
    @StateObject private var viewModel: CheckoutViewModel
    @State private var hasLoadedContentAppeared = false
    private let onOrderConfirmed: (CheckoutOrderConfirmation) -> Void

    init(
        viewModel: CheckoutViewModel,
        onOrderConfirmed: @escaping (CheckoutOrderConfirmation) -> Void = { _ in }
    ) {
        self._viewModel = StateObject(wrappedValue: viewModel)
        self.onOrderConfirmed = onOrderConfirmed
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
        .onChange(of: viewModel.state) { state in
            guard case .success = state else {
                hasLoadedContentAppeared = false
                return
            }

            hasLoadedContentAppeared = false

            withAnimation(.spring(response: 0.42, dampingFraction: 0.86)) {
                hasLoadedContentAppeared = true
            }
        }
        .onChange(of: viewModel.orderPlacement.confirmation?.id) { _ in
            guard let confirmation = viewModel.orderPlacement.confirmation else { return }
            onOrderConfirmed(confirmation)
        }
        .alert(
            CheckoutText.checkoutErrorTitle,
            isPresented: Binding(
                get: { viewModel.orderPlacement.errorMessage != nil },
                set: { isPresented in
                    if !isPresented {
                        viewModel.dismissCheckoutError()
                    }
                }
            )
        ) {
            Button(CheckoutText.checkoutErrorDismissTitle, role: .cancel) {
                viewModel.dismissCheckoutError()
            }
        } message: {
            Text(viewModel.orderPlacement.errorMessage ?? "")
        }
    }

    @ViewBuilder
    private var content: some View {
        switch viewModel.state {
        case .idle, .loading:
            CheckoutLoadingView()

        case .success(let loadedState):
            checkoutContent(cart: loadedState.cart)

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
                    methods: viewModel.paymentSelection.methods,
                    selectedType: viewModel.paymentSelection.selectedMethodType,
                    onSelect: viewModel.selectPaymentMethod(_:)
                )

                CheckoutOrderSummarySection(cart: cart)

                CheckoutPrimaryButton(
                    title: CheckoutText.checkoutButtonTitle,
                    isDisabled: viewModel.orderPlacement.isCheckoutButtonDisabled,
                    action: {
                        Task {
                            await viewModel.checkoutNow()
                        }
                    }
                )
            }
            .padding(.horizontal, 22)
            .padding(.top, 18)
            .padding(.bottom, 28)
        }
        .background(AppColors.background)
        .opacity(hasLoadedContentAppeared ? 1 : 0)
        .offset(y: hasLoadedContentAppeared ? 0 : 18)
        .onAppear {
            withAnimation(.spring(response: 0.42, dampingFraction: 0.86)) {
                hasLoadedContentAppeared = true
            }
        }
    }

}
