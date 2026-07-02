//
//  SwiftUIView.swift
//  
//
//  Created by Esraa Ehab on 02/07/2026.
//

import SwiftUI

@available(iOS 14.0, *)
public struct SettingsSectionView<Content: View>: View {
    let title: String
    let content: Content
    
    public init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title.uppercased())
                .font(.system(size: 13, weight: .bold))
                .foregroundColor(.black.opacity(0.8))
                .padding(.horizontal, 4)
            
            VStack(spacing: 0) {
                content
            }
            .padding(.horizontal, 16)
            .background(Color.white)
            .cornerRadius(20)
        }
    }
}
