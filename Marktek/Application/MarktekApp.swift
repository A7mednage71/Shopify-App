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
    private let persistenceController = PersistenceController.shared
    
    @StateObject private var localizationManager = LocalizationManager.shared
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    var body: some Scene {
        WindowGroup {
            ZStack {
                AppFlowView(authState: authState)
                    .tint(AppColors.primary)
                    .preferredColorScheme(isDarkMode ? .dark : .light)
                    .environment(\.locale, Locale(identifier: localizationManager.appLanguage))
                    .environment(\.layoutDirection, localizationManager.currentLanguage.layoutDirection)
                    .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                    .id(localizationManager.updateId)
            }
            .animation(.easeInOut(duration: 0.5), value: localizationManager.updateId)
            .task {
                await CurrencyService.shared.fetchLatestRates()
            }
            .onOpenURL { url in
                GIDSignIn.sharedInstance.handle(url)
            }
        }
    }
}
