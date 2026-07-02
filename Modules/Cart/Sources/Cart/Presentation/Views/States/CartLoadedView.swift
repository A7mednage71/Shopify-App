import Common
import SwiftUI

struct CartLoadedView: View {
    let cart: CartDetails
    let errorMessage: String?
    let discountCodeText: String
    let appliedDiscountCode: String?
    let isApplyingDiscountCode: Bool
    let discountCodeErrorMessage: String?
    let onIncrement: (String) -> Void
    let onDecrement: (String) -> Void
    let onRemove: (String) -> Void
    let onDiscountCodeChange: (String) -> Void
    let onApplyDiscountCode: () -> Void
    let onRemoveDiscountCode: () -> Void
    let onCheckoutTap: () -> Void
    let onProductTap: (String) -> Void

    @State private var deletionConfirmation: CartDeletionConfirmation?
    @State private var toastMessage: String?
    @State private var toastDismissalTask: Task<Void, Never>?

    var body: some View {
        ZStack(alignment: .top) {
            VStack(spacing: 0) {
                List {
                    ForEach(Array(cart.lines.enumerated()), id: \.element.id) { index, line in
                        VStack(spacing: 0) {
                            CartLineRow(
                                line: line,
                                onIncrement: { onIncrement(line.id) },
                                onDecrement: { onDecrement(line.id) },
                                onProductTap: {
                                    guard let productID = line.variant?.product?.id else { return }
                                    onProductTap(productID)
                                }
                            )

                            if index < cart.lines.count - 1 {
                                Divider()
                                    .background(AppColors.border)
                                    .padding(.leading, 22)
                            }
                        }
                        .listRowInsets(EdgeInsets())
                        .listRowSeparator(.hidden)
                        .listRowBackground(AppColors.background)
                        .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                            Button() {
                                deletionConfirmation = CartDeletionConfirmation(
                                    lineID: line.id,
                                    itemTitle: line.productTitle
                                )
                            } label: {
                                Label(CartText.deleteActionTitle, systemImage: "trash")
                            }
                            .tint(.red)
                        }
                    }
                }
                .listStyle(.plain)
                .background(AppColors.background)
                .animation(.easeInOut(duration: 0.24), value: cartLineIDs)

                VStack(spacing: 12) {
                    CartDiscountCodeView(
                        codeText: discountCodeText,
                        appliedCode: appliedDiscountCode,
                        isApplying: isApplyingDiscountCode,
                        errorMessage: discountCodeErrorMessage,
                        onTextChange: onDiscountCodeChange,
                        onApply: onApplyDiscountCode,
                        onRemove: onRemoveDiscountCode
                    )
                    .padding(.horizontal, 22)

                    CartOrderSummaryView(cart: cart)
                        .padding(.horizontal, 22)

                    Button(action: onCheckoutTap, label: checkoutButtonLabel)
                    .buttonStyle(.plain)
                    .accessibilityLabel(CartText.checkoutButtonTitle)
                        .padding(.horizontal, 22)
                }
                .padding(.top, 12)
                .padding(.bottom, 18)
                .background(AppColors.background)
            }

            if let toastMessage {
                CartInlineErrorView(message: toastMessage)
                    .padding(.horizontal, 22)
                    .padding(.top, 10)
                    .transition(.move(edge: .top).combined(with: .opacity))
                    .zIndex(1)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onAppear {
            showToastIfNeeded(errorMessage)
        }
        .onChange(of: errorMessage) { newValue in
            showToastIfNeeded(newValue)
        }
        .onDisappear {
            toastDismissalTask?.cancel()
        }
        .alert(item: $deletionConfirmation) { confirmation in
            Alert(
                title: Text(CartText.deleteAlertTitle),
                message: Text(CartText.deleteAlertMessage(itemTitle: confirmation.itemTitle)),
                primaryButton: .destructive(Text(CartText.deleteAlertConfirmTitle)) {
                    withAnimation(.easeInOut(duration: 0.24)) {
                        onRemove(confirmation.lineID)
                    }
                },
                secondaryButton: .cancel(Text(CartText.deleteAlertCancelTitle))
            )
        }
    }

    private var cartLineIDs: [String] {
        cart.lines.map(\.id)
    }

    private func checkoutButtonLabel() -> some View {
        HStack(spacing: 10) {
            Text(CartText.checkoutButtonTitle)
            Image(systemName: "arrow.right")
                .font(.system(size: 17, weight: .bold))
        }
        .font(.system(size: 17, weight: .bold))
        .foregroundColor(AppColors.textWhite)
        .frame(maxWidth: .infinity)
        .frame(height: 58)
        .background(AppColors.primary)
        .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
        .shadow(color: AppColors.primary.opacity(0.28), radius: 16, x: 0, y: 10)
    }

    private func showToastIfNeeded(_ message: String?) {
        guard let message, !message.isEmpty else { return }

        toastDismissalTask?.cancel()

        withAnimation(.spring(response: 0.32, dampingFraction: 0.88)) {
            toastMessage = message
        }

        toastDismissalTask = Task {
            try? await Task.sleep(nanoseconds: 2_200_000_000)

            guard !Task.isCancelled else { return }

            await MainActor.run {
                withAnimation(.easeInOut(duration: 0.22)) {
                    toastMessage = nil
                }
            }
        }
    }
}

private struct CartDeletionConfirmation: Identifiable {
    let lineID: String
    let itemTitle: String

    var id: String { lineID }
}
