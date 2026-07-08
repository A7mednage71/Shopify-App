//
//  File.swift
//  
//
//  Created by Esraa Ehab on 07/07/2026.
//

import Swinject

public struct OrdersPresentationAssembly: Assembly {
    public init() {}

    public func assemble(container: Container) {
        container.register(OrdersViewModel.self) { resolver in
            OrdersViewModel(
                getOrdersUseCase: resolver.resolve(GetOrdersUseCaseProtocol.self)!
            )
        }

        container.register(OrdersViewFactory.self) { resolver in
            OrdersViewFactory(
                viewModel: resolver.resolve(OrdersViewModel.self)!
            )
        }
    }
}
