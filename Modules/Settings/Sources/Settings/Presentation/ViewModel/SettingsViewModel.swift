//
//  File.swift
//  
//
//  Created by Esraa Ehab on 02/07/2026.
//

import Foundation
import SwiftUI
import Common
import Authentication

@available(iOS 14.0, *)
@MainActor
public class SettingsViewModel: ObservableObject {
    
    @Published public var user: UserProfile
    @Published public private(set) var isSigningOut = false
    @Published public var signOutErrorMessage: String?
    
    @AppStorage("selectedCurrency") public var selectedCurrency: AppCurrency = .usd
    @AppStorage("isDarkMode") public var isDarkMode: Bool = false

    private let logoutUseCase: LogoutUseCase
    private let authState: AuthState
    
    public init(
        logoutUseCase: LogoutUseCase,
        authState: AuthState
    ) {
        self.logoutUseCase = logoutUseCase
        self.authState = authState
        self.user = UserProfile(
            name: "Julianna Rossi",
            email: "julianna.rossi@gmail.com"
        )
    }
    
    public func signOut() async {
        guard !isSigningOut else { return }

        isSigningOut = true
        signOutErrorMessage = nil

        do {
            try await logoutUseCase.execute()
            authState.markLoggedOut()
        } catch {
            signOutErrorMessage = error.localizedDescription
        }

        isSigningOut = false
    }
    
    public func convertPrice(priceInUSD: Double) -> String {
        let converted = priceInUSD * selectedCurrency.exchangeRateFromUSD
        let symbol = selectedCurrency.rawValue.components(separatedBy: " ").last ?? ""
        return String(format: "%.2f %@", converted, symbol)
    }
}
