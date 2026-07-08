import Common
import SwiftUI

struct CheckoutView: View {
    @StateObject private var viewModel: CheckoutViewModel
    @State private var hasLoadedContentAppeared = false
    private let onOrderConfirmed: (CheckoutOrderConfirmation) -> Void
    private let onAddAddressTap: (@escaping () -> Void) -> Void
    private let onAddressBookTap: (@escaping () -> Void) -> Void

    init(
        viewModel: CheckoutViewModel,
        onOrderConfirmed: @escaping (CheckoutOrderConfirmation) -> Void = { _ in },
        onAddAddressTap: @escaping (@escaping () -> Void) -> Void = { _ in },
        onAddressBookTap: @escaping (@escaping () -> Void) -> Void = { _ in }
    ) {
        self._viewModel = StateObject(wrappedValue: viewModel)
        self.onOrderConfirmed = onOrderConfirmed
        self.onAddAddressTap = onAddAddressTap
        self.onAddressBookTap = onAddressBookTap
    }

    var body: some View {
        ZStack {
            AppColors.background
                .ignoresSafeArea()

            content
                .transition(.opacity.combined(with: .scale(scale: 0.98)))

            if let loadingMessage = viewModel.orderPlacement.loadingMessage {
                CheckoutProcessingOverlay(message: loadingMessage)
                    .zIndex(1)
            }

            if let toast = viewModel.toast {
                VStack {
                    CheckoutTopToastView(
                        message: toast.message,
                        onDismiss: {
                            viewModel.dismissToast(id: toast.id)
                        }
                    )
                        .padding(.horizontal, 18)
                        .padding(.top, 12)

                    Spacer()
                }
                .transition(.move(edge: .top).combined(with: .opacity))
                .zIndex(2)
            }
        }
        .navigationTitle(CheckoutText.navigationTitle)
        .checkoutNavigationTitleStyle()
        .task {
            await viewModel.load()
        }
        .task(id: viewModel.toast?.id) {
            guard let toastID = await MainActor.run(body: { viewModel.toast?.id }) else { return }
            do {
                try await Task.sleep(nanoseconds: 2_500_000_000)
            } catch {
                return
            }
            await MainActor.run {
                viewModel.dismissToast(id: toastID)
            }
        }
        .animation(.easeInOut(duration: 0.22), value: viewModel.state)
        .animation(.easeInOut(duration: 0.22), value: viewModel.addressState)
        .animation(.easeInOut(duration: 0.18), value: viewModel.orderPlacement.isPlacingOrder)
        .animation(.spring(response: 0.28, dampingFraction: 0.86), value: viewModel.toast)
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
                CheckoutAddressSection(
                    state: viewModel.addressState,
                    onAddAddressTap: requestAddAddress,
                    onSelectedAddressTap: requestAddressBook
                )

                CheckoutProductsSection(lines: cart.lines)

                CheckoutShippingMethodSection(
                    methods: viewModel.shippingSelection.methods,
                    selectedMethod: viewModel.shippingSelection.selectedMethod,
                    onSelect: viewModel.selectShippingMethod(_:)
                )

                CheckoutPaymentMethodSection(
                    methods: viewModel.paymentSelection.methods,
                    selectedType: viewModel.paymentSelection.selectedMethodType,
                    onSelect: viewModel.selectPaymentMethod(_:)
                )

                CheckoutOrderSummarySection(
                    cart: cart,
                    selectedShippingMethod: viewModel.shippingSelection.selectedMethod,
                    pricing: viewModel.shippingSelection.pricing
                )

                CheckoutPrimaryButton(
                    title: CheckoutText.checkoutButtonTitle,
                    isDisabled: viewModel.orderPlacement.isCheckoutButtonDisabled || viewModel.shippingSelection.pricing == nil,
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

    private func requestAddAddress() {
        onAddAddressTap {
            Task {
                await viewModel.refreshCustomerDetails()
            }
        }
    }

    private func requestAddressBook() {
        onAddressBookTap {
            Task {
                await viewModel.refreshCustomerDetails()
            }
        }
    }
}

private struct CheckoutTopToastView: View {
    let message: String
    let onDismiss: () -> Void

    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: "exclamationmark.circle.fill")
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(AppColors.textWhite)

            Text(message)
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(AppColors.textWhite)
                .fixedSize(horizontal: false, vertical: true)

            Spacer(minLength: 0)

            Button(action: onDismiss) {
                Image(systemName: "xmark.circle.fill")
                    .font(.system(size: 17, weight: .bold))
                    .foregroundColor(AppColors.textWhite.opacity(0.9))
            }
            .buttonStyle(.plain)
            .accessibilityLabel(L10n.Checkout.dismissAccessibilityLabel)
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 12)
        .background(AppColors.error.opacity(0.96))
        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
        .shadow(color: AppColors.shadow.opacity(0.18), radius: 14, x: 0, y: 8)
    }
}
