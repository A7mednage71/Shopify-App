import Foundation

struct SettingsViewModelFactory {
    @MainActor
    func makeViewModel() -> SettingsViewModel {
        SettingsViewModel()
    }
}
