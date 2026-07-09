//
//  String+Validation.swift
//  Common
//
//  Created by Antigravity on 09/07/2026.
//

import Foundation

public extension String {
    /// Validates if the string is a valid email address structure.
    var isValidEmail: Bool {
        let emailRegex = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}$"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        guard emailPredicate.evaluate(with: self) else { return false }
        
        // Exclude domains that start with 'www.' (e.g. user@www.com or user@www.gmail.com)
        if let domain = self.split(separator: "@").last, domain.lowercased().hasPrefix("www.") {
            return false
        }
        
        return true
    }
}
