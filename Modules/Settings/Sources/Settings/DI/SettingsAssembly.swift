//
//  File.swift
//  
//
//  Created by Esraa Ehab on 03/07/2026.
//

import Swinject

public final class SettingsAssembly: Assembly {
    public init() {}
    
    public func assemble(container: Container) {
        container.register(SettingsViewFactory.self) { _ in
            SettingsViewFactory()
        }
    }
}
