//
//  File.swift
//  
//
//  Created by Esraa Ehab on 03/07/2026.
//

import Foundation
import SwiftUI

public struct SettingsViewFactory {
    private let viewModelFactory: SettingsViewModelFactory
    
    init(viewModelFactory: SettingsViewModelFactory) {
        self.viewModelFactory = viewModelFactory
    }

    @MainActor
    public func makeSettingsDestinationView() -> some View {
        SettingsView(viewModel: viewModelFactory.makeViewModel())
    }
}
