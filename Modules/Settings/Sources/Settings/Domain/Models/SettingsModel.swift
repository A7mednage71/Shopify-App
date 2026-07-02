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

public enum AppCurrency: String, CaseIterable, Identifiable {
    case usd = "USD ($)"
    case eur = "Euro (€)"
    case egp = "EGP (E£)"
    case gbp = "GBP (£)"
    
    public var id: String { self.rawValue }
    
    public var exchangeRateFromUSD: Double {
        switch self {
        case .usd: return 1.0
        case .eur: return 0.92
        case .egp: return 48.50
        case .gbp: return 0.79
        }
    }
}
