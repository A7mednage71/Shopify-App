import Foundation

let bundleURL = URL(fileURLWithPath: "Modules/Common/.build/arm64-apple-macosx/debug/Common_Common.bundle")
if let bundle = Bundle(url: bundleURL) {
    if let path = bundle.path(forResource: "en", ofType: "lproj") {
        print("Found en.lproj at: \(path)")
        if let lprojBundle = Bundle(path: path) {
            print("Successfully created Bundle for en.lproj")
            let str = NSLocalizedString("settings_profile", tableName: "Localizable", bundle: lprojBundle, value: "fallback", comment: "")
            print("String: \(str)")
        } else {
            print("Failed to create Bundle for en.lproj")
        }
    } else {
        print("Could not find en.lproj in bundle")
    }
} else {
    print("Could not load bundle")
}
