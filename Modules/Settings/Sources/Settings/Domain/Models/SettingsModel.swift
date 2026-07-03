//
//  File.swift
//  
//
//  Created by Esraa Ehab on 02/07/2026.
//

import Foundation

public struct UserProfile {
    public let name: String
    public let email: String
    public let profileImageURL: String?
    
    public init(name: String, email: String, profileImageURL: String? = nil) {
        self.name = name
        self.email = email
        self.profileImageURL = profileImageURL
    }
}
