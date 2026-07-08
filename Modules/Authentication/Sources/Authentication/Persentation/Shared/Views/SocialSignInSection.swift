//
//  SocialSignInSection.swift
//
//
//  Created by Eyad waleed on 28/06/2026.
//

import SwiftUI
import Common

public struct SocialSignInSection: View {
    var guestAction: () -> Void
    var appleAction: () -> Void
    var googleAction: () -> Void

    public var body: some View {
        VStack {
            Text(L10n.Auth.orContinueWith)
                .font(.system(size: 12, design: .default))
            Spacer().frame(height: 35)
            HStack {
                CutomeCircularBtn(image: "person", label: "Guest", action: guestAction)
                //CutomeCircularBtn(image: "apple", action: appleAction)
                CutomeCircularBtn(image: "google", action: googleAction)
            }
        }
    }
}
