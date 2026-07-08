import SwiftUI
import Combine

@available(iOS 14.0, *)
public class LocalizationManager: ObservableObject {
    public static let shared = LocalizationManager()
    
    @Published public var updateId: UUID = UUID()
    
    @AppStorage("app_language") public var appLanguage: String = "en" {
        didSet {
            updateId = UUID()
            objectWillChange.send()
        }
    }
    
    public var currentLanguage: AppLanguage {
        get { AppLanguage(rawValue: appLanguage) ?? .en }
        set { appLanguage = newValue.rawValue }
    }
    
    private init() {}
    
    public func localizedString(for key: String) -> String {
        guard let path = Bundle.module.path(forResource: currentLanguage.rawValue, ofType: "lproj"),
              let bundle = Bundle(path: path) else {
            return Bundle.module.localizedString(forKey: key, value: nil, table: nil)
        }
        return bundle.localizedString(forKey: key, value: nil, table: nil)
    }
}
