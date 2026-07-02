//
//  AuthBottomPrompt.swift
//
//
//  Created by Eyad waleed on 28/06/2026.
//

import SwiftUI
import Common

@available(iOS 14.0, *)
struct AuthBottomPrompt: View {
    var promptText: String
    var actionText: String
    var action: () -> Void

    var body: some View {
        HStack {
            Text(promptText)
                .font(.system(size: 14))
            Button(action: action) {
                Text(actionText)
                    .font(.system(size: 12, weight: .bold))
                    .foregroundColor(AppColors.primary)
            }
        }
    }
}
