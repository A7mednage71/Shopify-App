//
//  File.swift
//  
//
//  Created by Esraa Ehab on 02/07/2026.
//

import Foundation

public enum AppCurrency: String, CaseIterable, Identifiable {
    case usd = "USD ($)"
    case eur = "Euro (€)"
    case egp = "EGP (E£)"
    case gbp = "GBP (£)"
    
    public var id: String { self.rawValue }
    
    public var symbol: String {
        switch self {
        case .usd: return "$"
        case .eur: return "€"
        case .egp: return "E£"
        case .gbp: return "£"
        }
    }
    
    public var exchangeRateFromUSD: Double {
            switch self {
            case .usd: return 1.0
            case .eur: return CurrencyService.shared.getRate(for: "EUR")
            case .egp: return CurrencyService.shared.getRate(for: "EGP")
            case .gbp: return CurrencyService.shared.getRate(for: "GBP")
            }
        }
}
