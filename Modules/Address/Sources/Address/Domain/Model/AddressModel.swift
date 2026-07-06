//
//  File.swift
//  
//
//  Created by Eyad waleed on 04/07/2026.
//

import Foundation
import Foundation

public struct AddressDomain: Equatable {
    public let id: String
    public let address1: String
    public let address2: String?
    public let city:String
    public let province: String?
    public let zip: String
    public let country: String
    public let firstName: String
    public let lastName: String
    public let phone: String?

    public init(
        id: String,
        address1: String,
        address2: String?,
        city: String,
        province: String?,
        zip: String,
        country: String,
        firstName: String,
        lastName: String,
        phone: String?
    ) {
        self.id = id
        self.address1 = address1
        self.address2 = address2
        self.city = city
        self.province = province
        self.zip = zip
        self.country = country
        self.firstName = firstName
        self.lastName = lastName
        self.phone = phone
    }
}


