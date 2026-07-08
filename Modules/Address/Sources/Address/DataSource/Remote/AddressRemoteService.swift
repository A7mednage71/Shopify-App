//
//  File.swift
//  
//
//  Created by Eyad waleed on 04/07/2026.
//

import Foundation

public protocol AddressApiDataSourceProtocol {
 
    func  fetchCustomerAddresses(customerAccessToken: String) async throws -> CustomerAddressesDTO
    func createAddress(customerAccessToken: String, address: NewAddressDTO) async throws -> AddressDTO

    func setDefaultAddress(customerAccessToken: String, addressId: String) async throws
    func deleteAddress(customerAccessToken: String, id: String) async throws
}
