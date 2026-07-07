//
//  File.swift
//  
//
//  Created by Eyad waleed on 04/07/2026.
//

import Foundation

public enum AddressError: Error {
    case notFound
    case invalidInput
    case networkError
    case unauthorized
    case unknown
    case emptyAddresses
}

