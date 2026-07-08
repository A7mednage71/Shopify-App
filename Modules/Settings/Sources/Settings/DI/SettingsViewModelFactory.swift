import Authentication
import Common
import Foundation

struct SettingsViewModelFactory {
    private let logoutUseCase: LogoutUseCase

    init(logoutUseCase: LogoutUseCase) {
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
