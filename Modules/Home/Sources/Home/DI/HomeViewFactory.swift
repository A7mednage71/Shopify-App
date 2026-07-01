import SwiftUI

public enum HomeViewFactory {
    @MainActor
    public static func makeHomeView() -> some View {
        HomeView(
            viewModel: HomeViewModel(
                getCollectionsUseCase: HomeAssembler.resolveGetCollectionsUseCase()
            )
        )
    }
}
