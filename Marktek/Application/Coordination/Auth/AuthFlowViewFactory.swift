import SwiftUI
import Authentication
struct AuthFlowViewFactory {
    @MainActor
    static func makeView(
        onAuthenticated: @escaping () -> Void,
        onContinueAsGuest: @escaping () -> Void
    ) -> AuthFlowView {
        AuthFlowView(onAuthenticated: onAuthenticated, onContinueAsGuest:onContinueAsGuest )
    }
}

enum AuthFeatureViewFactoryResolver {
    @MainActor
    static func resolveAuthViewFactory() -> AuthViewFactory {
        guard let factory = DIContainer.shared.resolver.resolve(AuthViewFactory.self) else {
            fatalError("Unable to resolve AuthViewFactory. Check AuthAssembly registration.")
        }
        return factory
    }
}


extension AuthViewFactory {
    @MainActor
    static func resolved() -> AuthViewFactory {
        AuthFeatureViewFactoryResolver.resolveAuthViewFactory()
    }
}
