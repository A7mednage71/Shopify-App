//
//  MarktekApp.swift
//  Marktek
//
//  Created by Eyad waleed on 27/06/2026.
//
import FirebaseCore
import Home
import GoogleSignIn
import Persistence
import SwiftUI
import Common
import Authentication
import Address
@available(iOS 14.0, *)
class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        return true
    }

}

@main
struct MarktekApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject private var authState = AuthState()
    @State private var isGuest = false
    @StateObject private var viewModel = DependencyInjector.shared.resolve(AddressesViewModel.self)
    private let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {



        }
    }
}

