//
//  MarktekApp.swift
//  Marktek
//
//  Created by Eyad waleed on 27/06/2026.
//
import FirebaseAuth
import FirebaseCore
import Home
import GoogleSignIn
import Persistence
import SwiftUI
import Common
import Authentication
import Common
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
    @StateObject private var viewModel = DependencyInjector.shared.resolve(AddressesViewModel.self)
    private let persistenceController = PersistenceController.shared
    
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    var body: some Scene {
        WindowGroup {
            AppFlowView(authState: authState)
            .preferredColorScheme(isDarkMode ? .dark : .light)
                .task {
                    await CurrencyService.shared.fetchLatestRates()
                }.onOpenURL { url in
                GIDSignIn.sharedInstance.handle(url)
            }
        }
    }
}
