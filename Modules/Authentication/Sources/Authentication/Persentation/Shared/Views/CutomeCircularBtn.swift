//
//  SwiftUIView 2.swift
//  
//
//  Created by Eyad waleed on 28/06/2026.
//

import SwiftUI

struct CutomeCircularBtn: View {
    var image : String
    var action: () -> Void
    @available(iOS 13.0.0, *)
    var body: some View {
        Button {
            action()
        } label: {
            Image(image)
                .resizable()
                .scaledToFit()
                .padding(12)
                .frame(width: 54, height: 54)
                .background(Color(red: 252/255, green: 243/255, blue: 246/255))
                .clipShape(Circle())
                .overlay(
                    Circle()
                        .stroke(Color(red: 255/255, green: 161/255, blue: 2/255), lineWidth: 1)
                )
        }
    }
}
