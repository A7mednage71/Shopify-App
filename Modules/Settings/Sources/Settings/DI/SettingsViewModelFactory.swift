import Common
import Foundation

struct SettingsViewModelFactory {
    private let logoutUseCase: any LogoutUseCaseProtocol

    init(logoutUseCase: any LogoutUseCaseProtocol) {
        self.logoutUseCase = logoutUseCase
    }

    @MainActor
    func makeViewModel(authState: AuthState) -> SettingsViewModel {
        SettingsViewModel(
            logoutUseCase: logoutUseCase,
            authState: authState
        )
        
    }
}
