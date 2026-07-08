//
//  File.swift
//  
//
//  Created by Esraa Ehab on 03/07/2026.
//

import Foundation
import Common
import SwiftUI

public struct SettingsViewFactory {
    private let viewModelFactory: SettingsViewModelFactory
    
    init(viewModelFactory: SettingsViewModelFactory) {
        self.viewModelFactory = viewModelFactory
    }

    @MainActor
    public func makeSettingsDestinationView(authState: AuthState) -> some View {
        SettingsView(viewModel: viewModelFactory.makeViewModel(authState: authState))
    }

    @MainActor
    public func makePersonalInformationView(authState: AuthState) -> some View {
        PersonalInformationView(viewModel: viewModelFactory.makeProfileDataViewModel())
    }

    @MainActor
    public func makeSettingsView(
        authState: AuthState,
        onPersonalInformationTap: @escaping () -> Void,
        onSavedAddressesTap: @escaping () -> Void,
        onOrdersTap: @escaping () -> Void
    ) -> some View {
        SettingsView(
            viewModel: viewModelFactory.makeViewModel(authState: authState),
            onPersonalInformationTap: onPersonalInformationTap,
            onSavedAddressesTap: onSavedAddressesTap,
            onOrdersTap: onOrdersTap
        )
    }
}
