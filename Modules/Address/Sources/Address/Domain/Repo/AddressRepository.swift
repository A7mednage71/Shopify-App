//
//  File.swift
//  
//
//  Created by Eyad waleed on 04/07/2026.
//

import Foundation
public protocol AddressRepository {
    func getAddresses() async throws -> ( AddressDomain , [AddressDomain])
    func createAddress( address: AddressDomain) async throws -> AddressDomain
    func setDefaultAddress( addressId: String) async throws
    func deleteAddress(id: String) async throws
    func createDefaultAddress( address: AddressDomain) async throws -> AddressDomain
}
