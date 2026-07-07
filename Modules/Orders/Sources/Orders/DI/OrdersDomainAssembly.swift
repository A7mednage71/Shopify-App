//
//  File.swift
//  
//
//  Created by Esraa Ehab on 07/07/2026.
//

import Swinject

public struct OrdersDomainAssembly: Assembly {
    public init() {}

    public func assemble(container: Container) {
        container.register(GetOrdersUseCaseProtocol.self) { resolver in
            GetOrdersUseCase(
                repository: resolver.resolve(OrdersRepository.self)!
            )
        }
    }
}
