//
//  File.swift
//  
//
//  Created by Eyad waleed on 05/07/2026.
//

import Foundation
import Swinject



public final class DependencyInjector {
    public static let shared = DependencyInjector()

    let container = Container()
    let assembler: Assembler

    private init() {
        self.assembler = Assembler([AddressAssembly()], container: container)
    }

    public func resolve<T>(_ serviceType: T.Type) -> T {  
        guard let resolved = container.resolve(serviceType) else {
            fatalError("Failed to resolve dependency for \(serviceType)")
        }
        return resolved
    }
}
