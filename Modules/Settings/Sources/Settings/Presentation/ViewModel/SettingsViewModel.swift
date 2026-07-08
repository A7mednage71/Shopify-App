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
@MainActor
public class SettingsViewModel: ObservableObject {
    @Published public private(set) var isSigningOut = false
    @Published public var signOutErrorMessage: String?
    
    @AppStorage("selectedCurrency") public var selectedCurrency: AppCurrency = .usd
    @AppStorage("isDarkMode") public var isDarkMode: Bool = false

    public let profileDataViewModel: ProfileDataViewModel
    private let logoutUseCase: any LogoutUseCaseProtocol
    private let authState: AuthState

    public var canUseProtectedFeatures: Bool {
        authState.canUseProtectedFeatures
    }
    
    public init(
        logoutUseCase: any LogoutUseCaseProtocol,
        authState: AuthState,
        profileDataViewModel: ProfileDataViewModel
    ) {
        self.logoutUseCase = logoutUseCase
        self.authState = authState
        self.profileDataViewModel = profileDataViewModel
    }
    
    public func signOut() async {
        guard !isSigningOut else { return }

        isSigningOut = true
        signOutErrorMessage = nil

        do {
            try await logoutUseCase.execute()
            profileDataViewModel.reset()
            authState.markLoggedOut()
        } catch {
            signOutErrorMessage = error.localizedDescription
        }

        isSigningOut = false
    }

    public func signIn() {
        authState.markNeedsLogin()
    }
    
    public func convertPrice(priceInUSD: Double) -> String {
        let converted = priceInUSD * selectedCurrency.exchangeRateFromUSD
        let symbol = selectedCurrency.rawValue.components(separatedBy: " ").last ?? ""
        return String(format: "%.2f %@", converted, symbol)
    }
}
