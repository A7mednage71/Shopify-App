//
//  File.swift
//  
//
//  Created by Esraa Ehab on 03/07/2026.
//

import Foundation
import SwiftUI

public struct SettingsViewFactory {
    
    public init() {}

    @MainActor
    public func makeSettingsView() -> some View {
        SettingsView()
    }
}
