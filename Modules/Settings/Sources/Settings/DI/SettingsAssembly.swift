//
//  File.swift
//  
//
//  Created by Esraa Ehab on 03/07/2026.
//

import Swinject
import Authentication

public final class SettingsAssembly: Assembly {
    public init() {}
    
    public func assemble(container: Container) {
        container.register(SettingsViewModelFactory.self) { resolver in
            SettingsViewModelFactory(
                logoutUseCase: resolver.resolve(LogoutUseCase.self)!
            )
        }

        container.register(SettingsViewFactory.self) { resolver in
            SettingsViewFactory(
                viewModelFactory: resolver.resolve(SettingsViewModelFactory.self)!
            )
        }
    }
}
