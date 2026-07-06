//
//  SwiftUIView 2.swift
//  
//
//  Created by Eyad waleed on 04/07/2026.
//

import SwiftUI

import SwiftUI
import Common
struct SelectionCircle: View {
    let isSelected: Bool

    var body: some View {
        ZStack {
            if isSelected {
                Circle()
                    .stroke(AppColors.primaryLight, lineWidth: 2)
                    .frame(width: 28, height: 28)

                Circle()
                    .fill(AppColors.primary)
                    .frame(width: 20, height: 20)
            } else {
                Circle()
                    .stroke(AppColors.border, lineWidth: 1.5)
                    .frame(width: 20, height: 20)
            }
        }
        .frame(width: 28, height: 28)  
        .animation(.easeInOut(duration: 0.15), value: isSelected)
    }
}

struct SelectableRow: View {
    @State private var isSelected = false

    var body: some View {
        Button {
            isSelected.toggle()
        } label: {
            SelectionCircle(isSelected: isSelected)
        }
        .buttonStyle(.plain)
    }
}



