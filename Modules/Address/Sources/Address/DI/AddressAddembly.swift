//
//  File.swift
//  
//
//  Created by Eyad waleed on 05/07/2026.
//

import Foundation
import Swinject

public final class AddressAssembly : Assembly{
    public init () {}
        @MainActor
    public func assemble(container : Container){
        container.register(AddressApiDataSourceProtocol.self){
            _ in AddressApiDataSource.shared
        }
        
        container.register(AddressRepository.self){
            it in
            AddressRepositoryImpl(dataSource: it.resolve(AddressApiDataSourceProtocol.self)!)
        }
  
        
        container.register(SetDefaultAddressUseCase.self) { resolver in
            SetDefaultAddressUseCase(repository: resolver.resolve(AddressRepository.self)!)
        }
        
        container.register(DeleteAddressUseCase.self) { resolver in
            DeleteAddressUseCase(repository: resolver.resolve(AddressRepository.self)!)
        }
        container.register(GetAllAddressesUseCase.self) { resolver in
            GetAllAddressesUseCase(repository: resolver.resolve(AddressRepository.self)!)
        }
        
        container.register(CreateAddressUseCase.self) { resolver in
            CreateAddressUseCase(repository: resolver.resolve(AddressRepository.self)!)
        }
        container.register(CustomerApiDataSourceProtocol.self){
            resolver in
            CustomerApiDataSource.shared
        }
        
        container.register(CustomerRepository.self){
            resolver in
            CustomerRepositoryImpl() }
            
            container.register(GetCustomerNameUseCase.self){
                resolver  in GetCustomerNameUseCase(repository: resolver.resolve(CustomerRepository.self)!)
                
            }
            
            container.register(AddressesViewModel.self) { resolver in
                AddressesViewModel(
                    getAllAddressesUseCase: resolver.resolve(GetAllAddressesUseCase.self)!,
                    setDefaultAddressUseCase: resolver.resolve(SetDefaultAddressUseCase.self)!,
                    deleteAddressUseCase: resolver.resolve(DeleteAddressUseCase.self)!, createAddressUseCase:
                        resolver.resolve(CreateAddressUseCase.self)!,
                    getUserName: resolver.resolve(GetCustomerNameUseCase.self)!
                    
                )
            }

            container.register(AddressViewFactory.self) { resolver in
                AddressViewFactory(
                    makeAddressesViewModel: {
                        resolver.resolve(AddressesViewModel.self)!
                    }
                )
            }
            
        }
    }

