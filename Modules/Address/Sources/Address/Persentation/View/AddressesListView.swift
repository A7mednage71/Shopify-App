import SwiftUI
import Common
@available(iOS 16.0, *)
public struct SwiftUIView: View {
    @StateObject private var viewModel: AddressesViewModel
    @State private var isShowingMap = false
    public init(viewModel: AddressesViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    public var body: some View {
        Group {
            switch viewModel.state {
            case .initialState, .loading:
                ProgressView("Loading addresses...")
                    .foregroundColor(AppColors.textPrimary)
                    .tint(AppColors.primary)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            case .NoAddressProvided:
                NoSavedAddressesView(onAddAddress: {
                    isShowingMap = true
                })

            case .addressFetched:
                AddressesView(viewModel: viewModel, onAddAddress: {
                    isShowingMap = true
                })
            case .networkProblem:
                NetworkProblemView()
            case .unKnownError:
                ServerErrorView()
            }
        }
        .background(AppColors.backgroundSecondary.ignoresSafeArea())
        .tint(AppColors.primary)
        .task {
            await viewModel.fetchAddresses()
        }
        .navigationDestination(isPresented: $isShowingMap) {
            AddressPickerView(onAddressConfirmed: { selected in
                Task {
                    await viewModel.createNewAddress(from: selected)
                    isShowingMap = false
                }
            })
        }
    }
}
