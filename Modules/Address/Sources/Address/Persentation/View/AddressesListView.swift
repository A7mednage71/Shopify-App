import SwiftUI
import Common
import Shimmer
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
                loadingSkeletonView
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
    
    private var loadingSkeletonView: some View {
        ScrollView {
            LazyVStack(spacing: 12) {
                ForEach(0..<4, id: \.self) { _ in
                    HStack(spacing: 16) {
                        Circle()
                            .fill(AppColors.backgroundSecondary)
                            .frame(width: 44, height: 44)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            RoundedRectangle(cornerRadius: 4)
                                .fill(AppColors.backgroundSecondary)
                                .frame(width: 120, height: 16)
                            
                            RoundedRectangle(cornerRadius: 4)
                                .fill(AppColors.backgroundSecondary)
                                .frame(width: 180, height: 12)
                            
                            RoundedRectangle(cornerRadius: 4)
                                .fill(AppColors.backgroundSecondary)
                                .frame(width: 150, height: 10)
                        }
                        Spacer()
                        
                        Circle()
                            .stroke(AppColors.border, lineWidth: 1.5)
                            .frame(width: 20, height: 20)
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 16)
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(AppColors.background)
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(AppColors.border.opacity(0.6), lineWidth: 1)
                    )
                }
            }
            .padding(.horizontal, 24)
            .padding(.top, 24)
        }
        .shimmering()
        .background(AppColors.backgroundSecondary.ignoresSafeArea())
    }
}
