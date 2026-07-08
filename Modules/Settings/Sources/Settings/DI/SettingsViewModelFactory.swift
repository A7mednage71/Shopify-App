import Common
import Foundation

struct SettingsViewModelFactory {
    private let logoutUseCase: any LogoutUseCaseProtocol
    private let profileDataViewModelProvider: ProfileDataViewModelProvider

    init(
        logoutUseCase: any LogoutUseCaseProtocol,
        profileDataViewModelProvider: ProfileDataViewModelProvider
    ) {
        self.logoutUseCase = logoutUseCase
        self.profileDataViewModelProvider = profileDataViewModelProvider
    }

    @MainActor
    func makeViewModel(authState: AuthState) -> SettingsViewModel {
        SettingsViewModel(
            logoutUseCase: logoutUseCase,
            authState: authState,
            profileDataViewModel: profileDataViewModelProvider.viewModel()
        )
    }

    @MainActor
    func makeProfileDataViewModel() -> ProfileDataViewModel {
        profileDataViewModelProvider.viewModel()
    }
}
