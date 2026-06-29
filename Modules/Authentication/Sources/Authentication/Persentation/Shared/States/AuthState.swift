//
//  File.swift
//  
//
//  Created by Eyad waleed on 28/06/2026.
//

import Foundation
enum AuthState  : Equatable{
    case idel
    case loading
    case success
    case error(String)
}
