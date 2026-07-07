//
//  File.swift
//  
//
//  Created by Eyad waleed on 04/07/2026.
//

import Foundation

extension AddressDTO {
    func toDomain() throws -> AddressDomain {
        let safeAddress1 = address1 ?? ""
        let safeCity = city ?? ""
        let safeCountry = country ?? ""
        let safeZip = zip ?? ""
        let safeFirstName = firstName ?? ""
        let safeLastName = lastName ?? ""
    

        return AddressDomain(
            id: id,
            address1: safeAddress1,
            address2: address2 ?? "",
            city: safeCity,
            province: province ?? "",
            zip: safeZip,
            country: safeCountry,
            firstName: safeFirstName,
            lastName: safeLastName,
            phone: phone ?? ""
        )
    }
}

extension AddressDomain {
    func toNewAddressDTO() -> NewAddressDTO {
        NewAddressDTO(
            address1: address1,
            address2: address2,
            city: city,
            province: province,
            zip: zip,
            country: country,
            firstName: firstName,
            lastName: lastName,
            phone: phone
        )
    }
}

extension CustomerProfileDTO {
    func toDomain() -> CustomerProfile {
        CustomerProfile(firstName: firstName, lastName: lastName)
    }
}
