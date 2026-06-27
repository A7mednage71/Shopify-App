//
//  SplashScreenView.swift
//  Marktek
//
//  Created by Esraa Ehab on 27/06/2026.
//

import SwiftUI
import Home

struct SplashScreenView: View {
    @State private var isActive = false
    
    var body: some View {
        if isActive {
           HomeScreenView()
        } else {
            ZStack {
                AppColors.primary
                    .ignoresSafeArea()
                
                VStack {
                    Image("marketek")
                        .resizable()
                        .scaledToFit() 
                        .frame(width: 250, height: 250, alignment: .center)
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                    withAnimation {
                        self.isActive = true
                    }
                }
            }
        }
    }
}

#Preview {
    SplashScreenView()
}
