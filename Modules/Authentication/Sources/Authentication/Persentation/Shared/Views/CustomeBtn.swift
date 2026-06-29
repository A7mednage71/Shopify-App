//
//  SwiftUIView 2.swift
//  
//
//  Created by Eyad waleed on 28/06/2026.
//

import SwiftUI
@available(iOS 13.0.0, *)
struct CustomBtn: View {
    var label: String
    var action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Text(label)
                .font(.system(size: 20, weight: .semibold))
                .foregroundColor(.white)
         
                .padding(.vertical, 14)
                .frame(maxWidth: .infinity)
                .background(Color(red: 255/255, green: 161/255, blue: 2/255))
                .cornerRadius(10).padding(.horizontal, 30)
        }
    }
}

