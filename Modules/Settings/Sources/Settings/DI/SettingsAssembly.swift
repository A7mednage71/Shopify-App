//
//  File.swift
//  
//
//  Created by Esraa Ehab on 03/07/2026.
//

import Swinject
import Common

public final class SettingsAssembly: Assembly {
    public init() {}
    
    public func assemble(container: Container) {
        container.register(CustomerProfileRemoteDataSource.self) { _ in
            ShopifyCustomerProfileRemoteDataSource()
        }

        container.register(CustomerProfileRepository.self) { resolver in
            CustomerProfileRepositoryImpl(
                remoteDataSource: resolver.resolve(CustomerProfileRemoteDataSource.self)!
            )
        }

        container.register(GetCustomerProfileUseCaseProtocol.self) { resolver in
            GetCustomerProfileUseCase(
                repository: resolver.resolve(CustomerProfileRepository.self)!
            )
        }

        container.register(UpdateCustomerProfileUseCaseProtocol.self) { resolver in
            UpdateCustomerProfileUseCase(
                repository: resolver.resolve(CustomerProfileRepository.self)!
            )
        }

        container.register(ProfileDataViewModelProvider.self) { resolver in
            ProfileDataViewModelProvider(
                getCustomerProfileUseCase: resolver.resolve(GetCustomerProfileUseCaseProtocol.self)!,
                updateCustomerProfileUseCase: resolver.resolve(UpdateCustomerProfileUseCaseProtocol.self)!
            )
        }
        .inObjectScope(.container)

        container.register(SettingsViewModelFactory.self) { resolver in
            SettingsViewModelFactory(
                logoutUseCase: resolver.resolve(LogoutUseCaseProtocol.self)!,
                profileDataViewModelProvider: resolver.resolve(ProfileDataViewModelProvider.self)!
            )
        }

        container.register(SettingsViewFactory.self) { resolver in
            SettingsViewFactory(
                viewModelFactory: resolver.resolve(SettingsViewModelFactory.self)!
            )
        }
    }
}
