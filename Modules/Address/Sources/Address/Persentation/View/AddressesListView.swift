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
        NavigationStack{
            Group {
                switch viewModel.state {
                case .initialState, .loading:
                    ProgressView("Loading addresses...")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                case .NoAddressProvided:
                    NoSavedAddressesView(onAddAddress: {
                        isShowingMap = true
                    })
                    
                case .addressFetched:
                    AddressesView(viewModel: viewModel , onAddAddress: {
                        isShowingMap = true
                    })
                case .networkProblem:
                    NetworkProblemView()
                case .unKnownError :
                    ServerErrorView()
        
                }
            }
            .task {
                await viewModel.fetchAddresses()
            } .navigationDestination(isPresented: $isShowingMap) {
                AddressPickerView(onAddressConfirmed: { selected in
                    Task { await viewModel.createNewAddress(from: selected)
                        isShowingMap = false
                        
                    }
                })
            }
        }
    }
}

