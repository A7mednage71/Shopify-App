import Foundation
import Common
public final class AddressRepositoryImpl: AddressRepository {
    private let dataSource: AddressApiDataSourceProtocol
    private let customerAccessTokenProvider: any CustomerAccessTokenProvider

    public init(
        dataSource: AddressApiDataSourceProtocol = AddressApiDataSource.shared,
        customerAccessTokenProvider: any CustomerAccessTokenProvider = KeychainCustomerAccessTokenProvider()
    ) {
        self.dataSource = dataSource
        self.customerAccessTokenProvider = customerAccessTokenProvider
    }

    private func validAccessToken() throws -> String {
        do {
            return try customerAccessTokenProvider.customerAccessToken()
        } catch {
            throw AddressError.unauthorized
        }
    }


    public func createAddress(address: AddressDomain) async throws -> AddressDomain {
        let token = try validAccessToken()
        let dto = try await dataSource.createAddress(customerAccessToken: token, address: address.toNewAddressDTO())
        return try dto.toDomain()
    }
 
    public func getAddresses() async throws -> ( AddressDomain , [AddressDomain]) {
        let token = try validAccessToken()

        let dto = try await dataSource.fetchCustomerAddresses(customerAccessToken: token)
       
        let defaultAddress = try dto.defaultAddress.toDomain()
        let defaultID = defaultAddress.id

        let otherAddresses = try dto.allAddresses
            .filter { address in
                address.id != defaultID || address.address1 != defaultAddress.address1  }
            .map { try $0.toDomain() }

        return (defaultAddress, otherAddresses)
    }




    

    public func setDefaultAddress(addressId: String) async throws {
        let token = try validAccessToken()
        try await dataSource.setDefaultAddress(customerAccessToken: token, addressId: addressId)
    }

    public func deleteAddress(id: String) async throws {
        let token = try validAccessToken()
        try await dataSource.deleteAddress(customerAccessToken: token, id: id)
    }

    public func createDefaultAddress(address: AddressDomain) async throws -> AddressDomain {
        let token = try validAccessToken()
        let createdDto = try await dataSource.createAddress(customerAccessToken: token, address: address.toNewAddressDTO())
        try await dataSource.setDefaultAddress(customerAccessToken: token, addressId: createdDto.id)
        return try createdDto.toDomain()
    }
}
