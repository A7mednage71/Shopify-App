import Common
import SwiftUI

@available(iOS 16.0, *)
public struct AddAddressFlowView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel: AddressesViewModel
    @State private var isSaving = false
    @State private var errorMessage: String?

    private let onAddressAdded: () -> Void
    private let onCancel: () -> Void

    public init(
        viewModel: AddressesViewModel,
        onAddressAdded: @escaping () -> Void,
        onCancel: @escaping () -> Void = {}
    ) {
        self._viewModel = StateObject(wrappedValue: viewModel)
        self.onAddressAdded = onAddressAdded
        self.onCancel = onCancel
    }

    public var body: some View {
        NavigationStack {
            ZStack {
                AddressPickerView(onAddressConfirmed: saveAddress(_:))

                if isSaving {
                    savingOverlay
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(L10n.Address.cancel) {
                        onCancel()
                        dismiss()
                    }
                }
            }
            .alert(L10n.Address.unavailableTitle,
                isPresented: Binding(
                    get: { errorMessage != nil },
                    set: { isPresented in
                        if !isPresented {
                            errorMessage = nil
                        }
                    }
                )
            ) {
                Button(L10n.Address.ok, role: .cancel) {
                    errorMessage = nil
                }
            } message: {
                Text(errorMessage ?? "")
            }
        }
    }

    private var savingOverlay: some View {
        ZStack {
            AppColors.shadow.opacity(0.24)
                .ignoresSafeArea()

            VStack(spacing: 12) {
                ProgressView()
                    .tint(AppColors.primary)

                Text(L10n.Address.saving)
                    .font(AppFonts.subheadline.weight(.semibold))
                    .foregroundColor(AppColors.textPrimary)
            }
            .padding(18)
            .background(AppColors.background)
            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
            .shadow(color: AppColors.shadow.opacity(0.18), radius: 18, x: 0, y: 10)
        }
    }

    private func saveAddress(_ selectedAddress: SelectedAddress) {
        guard !isSaving else { return }

        isSaving = true

        Task { @MainActor in
            let didCreateAddress = await viewModel.createNewAddress(
                from: selectedAddress,
                setCreatedAsDefault: true
            )

            isSaving = false

            if didCreateAddress {
                onAddressAdded()
                dismiss()
            } else {
                errorMessage = L10n.Address.saveFailedMessage
            }
        }
    }
}
