//
//  File 2.swift
//  
//
//  Created by Eyad waleed on 04/07/2026.
//

import Foundation

public enum AddressesViewState: Equatable {
    case initialState
    case loading
    case addressFetched
    case NoAddressProvided
    case networkProblem
    case unKnownError

}
