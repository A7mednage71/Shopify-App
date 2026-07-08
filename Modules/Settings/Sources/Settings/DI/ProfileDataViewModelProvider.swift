import Foundation

final class ProfileDataViewModelProvider {
    private let getCustomerProfileUseCase: any GetCustomerProfileUseCaseProtocol
    private let updateCustomerProfileUseCase: any UpdateCustomerProfileUseCaseProtocol

    @MainActor private var cachedViewModel: ProfileDataViewModel?

    init(
        getCustomerProfileUseCase: any GetCustomerProfileUseCaseProtocol,
        updateCustomerProfileUseCase: any UpdateCustomerProfileUseCaseProtocol
    ) {
        self.getCustomerProfileUseCase = getCustomerProfileUseCase
        self.updateCustomerProfileUseCase = updateCustomerProfileUseCase
    }

    @MainActor
    func viewModel() -> ProfileDataViewModel {
        if let cachedViewModel {
            return cachedViewModel
        }

        let viewModel = ProfileDataViewModel(
            getCustomerProfileUseCase: getCustomerProfileUseCase,
            updateCustomerProfileUseCase: updateCustomerProfileUseCase
        )
        cachedViewModel = viewModel
        return viewModel
    }
}
