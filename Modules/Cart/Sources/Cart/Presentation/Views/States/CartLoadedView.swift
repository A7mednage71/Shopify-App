import Common
import SwiftUI

struct CartLoadedView: View {
    let cart: CartDetails
    let errorMessage: String?
    let onIncrement: (String) -> Void
    let onDecrement: (String) -> Void
    let onRemove: (String) -> Void

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
                                onDecrement: { onDecrement(line.id) }
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
                    CartOrderSummaryView(cart: cart)
                        .padding(.horizontal, 22)

                    CartPrimaryButton(title: CartText.checkoutButtonTitle, action: {})
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
