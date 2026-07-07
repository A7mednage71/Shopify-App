import Common
import SwiftUI

@available(iOS 16.0, *)
public struct AddressBookFlowView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel: AddressesViewModel
    @State private var isAddAddressPresented = false

    private let onAddressChanged: () -> Void
    private let onCancel: () -> Void

    public init(
        viewModel: AddressesViewModel,
        onAddressChanged: @escaping () -> Void,
        onCancel: @escaping () -> Void = {}
    ) {
        self._viewModel = StateObject(wrappedValue: viewModel)
        self.onAddressChanged = onAddressChanged
        self.onCancel = onCancel
    }

    public var body: some View {
        NavigationStack {
            Group {
                switch viewModel.state {
                case .initialState, .loading:
                    ProgressView("Loading addresses...")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)

                case .NoAddressProvided:
                    NoSavedAddressesView {
                        isAddAddressPresented = true
                    }

                case .addressFetched:
                    AddressesView(
                        viewModel: viewModel,
                        onAddAddress: {
                            isAddAddressPresented = true
                        },
                        onSelectionApplied: handleAddressChanged
                    )

                case .networkProblem:
                    NetworkProblemView()

                case .unKnownError:
                    ServerErrorView()
                }
            }
            .navigationTitle("Delivery Address")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }

                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        onCancel()
                        dismiss()
                    }
                }
            }
            .task {
                await viewModel.fetchAddresses()
            }
            .sheet(isPresented: $isAddAddressPresented) {
                AddAddressFlowView(
                    viewModel: viewModel,
                    onAddressAdded: handleAddressChanged,
                    onCancel: {
                        isAddAddressPresented = false
                    }
                )
                .presentationDetents([.large])
                .presentationDragIndicator(.visible)
            }
        }
    }

    private func handleAddressChanged() {
        isAddAddressPresented = false
        onAddressChanged()
        dismiss()
    }
}
