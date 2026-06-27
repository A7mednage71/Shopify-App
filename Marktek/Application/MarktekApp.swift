//
//  MarktekApp.swift
//  Marktek
//
//  Created by Eyad waleed on 27/06/2026.
//

import SwiftUI
import Home

@main
struct MarktekApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            HomeScreenView()
        }
    }
}


