import Common
import SwiftUI

struct CheckoutView: View {
    @StateObject private var viewModel: CheckoutViewModel
    @State private var hasLoadedContentAppeared = false
    private let onOrderConfirmed: (CheckoutOrderConfirmationRoute) -> Void

    init(
        viewModel: CheckoutViewModel,
        onOrderConfirmed: @escaping (CheckoutOrderConfirmationRoute) -> Void = { _ in }
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
        .sheet(item: $viewModel.webCheckoutRoute) { route in
            NavigationStack {
                CheckoutWebView(url: route.url) { url in
                    viewModel.checkoutCompleted(url: url)
                }
                    .navigationTitle(CheckoutText.checkoutWebTitle)
                    .checkoutNavigationTitleStyle()
            }
        }
        .onChange(of: viewModel.orderConfirmationRoute?.id) { _ in
            guard let route = viewModel.orderConfirmationRoute else { return }
            onOrderConfirmed(route)
        }
        .alert(
            CheckoutText.checkoutErrorTitle,
            isPresented: Binding(
                get: { viewModel.checkoutErrorMessage != nil },
                set: { isPresented in
                    if !isPresented {
                        viewModel.checkoutErrorMessage = nil
                    }
                }
            )
        ) {
            Button(CheckoutText.checkoutErrorDismissTitle, role: .cancel) {
                viewModel.checkoutErrorMessage = nil
            }
        } message: {
            Text(viewModel.checkoutErrorMessage ?? "")
        }
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
