//
//  File.swift
//  
//
//  Created by Esraa Ehab on 02/07/2026.
//

import Foundation
import SwiftUI
import Common

@available(iOS 14.0, *)
public class SettingsViewModel: ObservableObject {
    
    @Published public var user: UserProfile
    
    @AppStorage("selectedCurrency") public var selectedCurrency: AppCurrency = .usd
    @AppStorage("isDarkMode") public var isDarkMode: Bool = false
    
    public init() {
        self.user = UserProfile(
            name: "Julianna Rossi",
            email: "julianna.rossi@gmail.com"
        )
    }
    
    public func signOut() {
        print("User signed out. Token cleared.")
    }
    
    public func convertPrice(priceInUSD: Double) -> String {
        let converted = priceInUSD * selectedCurrency.exchangeRateFromUSD
        let symbol = selectedCurrency.rawValue.components(separatedBy: " ").last ?? ""
        return String(format: "%.2f %@", converted, symbol)
    }
}
