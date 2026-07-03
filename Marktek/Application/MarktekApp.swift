//
//  MarktekApp.swift
//  Marktek
//
//  Created by Eyad waleed on 27/06/2026.
//

import FirebaseCore
import GoogleSignIn
import Persistence
import SwiftUI

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
    private let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            AppFlowView()
        }
    }
}
