//
//  File.swift
//  
//
//  Created by Eyad waleed on 04/07/2026.
//

import Foundation

public struct GetAllAddressesUseCase {
    private let repository: AddressRepository
    public init(repository: AddressRepository) { self.repository = repository }
    public func execute() async throws -> (AddressDomain,[AddressDomain]) {
      
            let result = try await repository.getAddresses()
            return result
        
      
            
        
    }
}

public struct CreateAddressUseCase {
    private let repository: AddressRepository
    public init(repository: AddressRepository) { self.repository = repository }

    public func execute( address: AddressDomain) async throws -> AddressDomain {
        try await repository.createAddress(  address: address)
    }
}



public struct SetDefaultAddressUseCase {
    private let repository: AddressRepository
    public init(repository: AddressRepository) { self.repository = repository }

    public func execute( addressId: String) async throws {
        try await repository.setDefaultAddress( addressId: addressId)
    }
}

public struct DeleteAddressUseCase {
    private let repository: AddressRepository
    public init(repository: AddressRepository) { self.repository = repository }

    public func execute( id: String) async throws {
        try await repository.deleteAddress(id: id)
    }
}

public struct CreateDefaultAddressUseCase {
    private let repository: AddressRepository
    public init(repository: AddressRepository) { self.repository = repository }

    public func execute( address: AddressDomain) async throws -> AddressDomain {
        try await repository.createDefaultAddress( address: address)
    }
}

public struct GetCustomerNameUseCase {
    private let repository: CustomerRepository
    public init(repository: CustomerRepository) { self.repository = repository }

    public func execute() async throws -> CustomerProfile {
        try await repository.getName()
    }
}

