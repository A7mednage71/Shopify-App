//
//  File.swift
//  
//
//  Created by Eyad waleed on 05/07/2026.
//

import Foundation
public protocol CustomerApiDataSourceProtocol {
    func fetchCustomerName(customerAccessToken: String) async throws -> CustomerProfileDTO
}
