import SwiftUI
import Common

public struct SplashView: View {
    var onAnimationFinished: () -> Void
    
    @State private var isAnimating = false
    @State private var scale: CGFloat = 0.5
    @State private var logoOpacity: Double = 0.0
    @State private var textOpacity: Double = 0.0
    @State private var textOffset: CGFloat = 20
    @State private var rippleScale: CGFloat = 0.8
    @State private var rippleOpacity: Double = 0.6
    @State private var secondRippleScale: CGFloat = 0.8
    @State private var secondRippleOpacity: Double = 0.4
    @State private var isGlowVisible = false

    public init(onAnimationFinished: @escaping () -> Void) {
        self.onAnimationFinished = onAnimationFinished
    }

    public var body: some View {
        ZStack {
            LinearGradient(
                colors: [
                    Color(red: 1.0, green: 0.95, blue: 0.90), // Very light peach
                    Color.white,
                    Color(red: 0.98, green: 0.95, blue: 0.92)  // Soft warm white
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            Group {
                Circle()
                    .stroke(AppColors.primary.opacity(0.3), lineWidth: 1.5)
                    .frame(width: 140, height: 140)
                    .scaleEffect(rippleScale)
                    .opacity(rippleOpacity)
                
                Circle()
                    .stroke(AppColors.primary.opacity(0.2), lineWidth: 1)
                    .frame(width: 140, height: 140)
                    .scaleEffect(secondRippleScale)
                    .opacity(secondRippleOpacity)
            }
            
            VStack(spacing: 20) {
                ZStack {
                    Circle()
                        .fill(AppColors.primary.opacity(0.12))
                        .frame(width: 160, height: 160)
                        .scaleEffect(isGlowVisible ? 1.15 : 0.9)
                        .blur(radius: 20)
                    Circle()
                        .fill(Color.white)
                        .frame(width: 120, height: 120)
                        .shadow(color: AppColors.primary.opacity(0.25), radius: 15, x: 0, y: 8)
                        .overlay(
                            AppImages.appIcon
                                .resizable()
                                .scaledToFit()
                                .frame(width: 80, height: 80)
                                .clipShape(Circle())
                                .overlay(
                                    Circle()
                                        .stroke(Color.white, lineWidth: 3)
                                )
                        )
                }
                .scaleEffect(scale)
                .opacity(logoOpacity)
                
                VStack(spacing: 6) {
                    Text(L10n.Common.appName)
                        .font(.system(size: 28, weight: .black, design: .rounded))
                        .tracking(4) 
                        .foregroundColor(AppColors.textPrimary)
                    
                    Text(L10n.Auth.smartShoppingAssistant)
                        .font(.system(size: 10, weight: .bold))
                        .tracking(2.5)
                        .foregroundColor(AppColors.primary)
                }
                .opacity(textOpacity)
                .offset(y: textOffset)
            }
        }
        .onAppear {
            startAnimation()
        }
    }
    
    private func startAnimation() {
        withAnimation(.easeOut(duration: 1.0)) {
            scale = 1.0
            logoOpacity = 1.0
        }
        
        withAnimation(.easeOut(duration: 1.8).delay(0.2)) {
            rippleScale = 2.4
            rippleOpacity = 0.0
        }
        
        withAnimation(.easeOut(duration: 1.8).delay(0.6)) {
            secondRippleScale = 2.4
            secondRippleOpacity = 0.0
        }
        
        withAnimation(.easeInOut(duration: 1.2).repeatForever(autoreverses: true)) {
            isGlowVisible = true
        }
        
        withAnimation(.easeOut(duration: 0.8).delay(0.6)) {
            textOpacity = 1.0
            textOffset = 0
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            withAnimation(.easeOut(duration: 0.4)) {
                onAnimationFinished()
            }
        }
    }
}
