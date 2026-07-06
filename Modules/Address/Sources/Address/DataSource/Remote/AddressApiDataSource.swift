//
//  File.swift
//  
//
//  Created by Eyad waleed on 04/07/2026.
//

import Foundation
import Foundation
import MarktekNetworking
import ShopifyAPI
@available(iOS 13.0.0, *)
public final class AddressApiDataSource: AddressApiDataSourceProtocol {
    public static let shared = AddressApiDataSource()
    private let client = ShopifyGraphQLClient.shared

    private init() {}

    public func fetchCustomerAddresses(customerAccessToken: String) async throws -> CustomerAddressesDTO {
        let query = GetCustomerAddressesQuery(customerAccessToken: customerAccessToken)

        let data: GetCustomerAddressesQuery.Data
        do {
            data = try await client.fetch(query)
        } catch {
            throw AddressError.networkError
        }

        guard let customer = data.customer else {
            throw AddressError.unauthorized
        }

         let defaultDto = customer.defaultAddress.map { node in
             AddressDTO(
                id: node.id, address1: node.address1, address2: node.address2,
                city: node.city, province: node.province, zip: node.zip,
                country: node.country, firstName: node.firstName,
                lastName: node.lastName, phone: node.phone
             )}
      

        let allDtos = customer.addresses.edges.map { edge in
            AddressDTO(
                id: edge.node.id, address1: edge.node.address1, address2: edge.node.address2,
                city: edge.node.city, province: edge.node.province, zip: edge.node.zip,
                country: edge.node.country, firstName: edge.node.firstName,
                lastName: edge.node.lastName, phone: edge.node.phone
            )
        }
        if (allDtos.isEmpty ){
            throw AddressError.emptyAddresses

        }

        return CustomerAddressesDTO(defaultAddress: defaultDto ??  AddressDTO(id: "", address1: "", address2: "", city: "", province: "", zip: "", country: "", firstName: "", lastName: "", phone: ""), allAddresses: allDtos)
    }



    public func createAddress(customerAccessToken: String, address: NewAddressDTO) async throws -> AddressDTO {
        let input = ShopifyAPI.MailingAddressInput(
            address1: .some(address.address1),
            address2: address.address2.map { .some($0) } ?? .none,
            city: .some(address.city),
            country: .some(address.country), firstName: .some(address.firstName), lastName: .some(address.lastName), phone: address.phone.map { .some($0) } ?? .none, province: address.province.map { .some($0) } ?? .none,
            zip: .some(address.zip)
        )

        let mutation = CreateCustomerAddressMutation(
            customerAccessToken: customerAccessToken,
            address: input
        )

        let data: CreateCustomerAddressMutation.Data
        do {
            data = try await client.perform(mutation)
        } catch {
            throw AddressError.networkError
        }

        let payload = data.customerAddressCreate

        if payload?.customerUserErrors.isEmpty == false {
            throw AddressError.invalidInput
        }

        guard let created = payload?.customerAddress else {
            throw AddressError.unknown
        }

        return AddressDTO(
            id: created.id,
            address1: created.address1,
            address2: created.address2,
            city: created.city,
            province: created.province,
            zip: created.zip,
            country: created.country,
            firstName: created.firstName,
            lastName: created.lastName,
            phone: created.phone
        )
    }


   public  func setDefaultAddress(customerAccessToken: String, addressId: String) async throws {
        let mutation = UpdateCustomerDefaultAddressMutation(
            customerAccessToken: customerAccessToken,
            addressId: addressId
        )

        let data: UpdateCustomerDefaultAddressMutation.Data
        do {
            data = try await client.perform(mutation)
        } catch {
            throw AddressError.networkError
        }

        if data.customerDefaultAddressUpdate?.customerUserErrors.isEmpty == false {
            throw AddressError.invalidInput
        }
    }

    public  func deleteAddress(customerAccessToken: String, id: String) async throws {
        let mutation = DeleteCustomerAddressMutation(
            customerAccessToken: customerAccessToken,
            id: id
        )

        let data: DeleteCustomerAddressMutation.Data
        do {
            data = try await client.perform(mutation)
        } catch {
            throw AddressError.networkError
        }

        if data.customerAddressDelete?.customerUserErrors.isEmpty == false {
            throw AddressError.invalidInput
        }
    }
}

