import SwiftUI

public struct AddressViewFactory {
    private let makeAddressesViewModel: @MainActor () -> AddressesViewModel

    init(makeAddressesViewModel: @escaping @MainActor () -> AddressesViewModel) {
        self.makeAddressesViewModel = makeAddressesViewModel
    }

    @MainActor
    @ViewBuilder
    public func makeAddressDestinationView() -> some View {
        if #available(iOS 16.0, *) {
            SwiftUIView(viewModel: makeAddressesViewModel())
        } else {
            Text("Addresses require iOS 16 or later.")
        }
    }

    @available(iOS 16.0, *)
    @MainActor
    public func makeAddAddressFlowView(
        onAddressAdded: @escaping () -> Void,
        onCancel: @escaping () -> Void = {}
    ) -> some View {
        AddAddressFlowView(
            viewModel: makeAddressesViewModel(),
            onAddressAdded: onAddressAdded,
            onCancel: onCancel
        )
    }

    @available(iOS 16.0, *)
    @MainActor
    public func makeAddressBookFlowView(
        onAddressChanged: @escaping () -> Void,
        onCancel: @escaping () -> Void = {}
    ) -> some View {
        AddressBookFlowView(
            viewModel: makeAddressesViewModel(),
            onAddressChanged: onAddressChanged,
            onCancel: onCancel
        )
    }
}
