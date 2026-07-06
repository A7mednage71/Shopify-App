import SwiftUI
import Common

struct TypingIndicator: View {
    @State private var animate = false

    init() {}

    public var body: some View {
        HStack(alignment: .center, spacing: 8) {
            // Placeholder for avatar alignment
            Circle()
                .fill(Color.clear)
                .frame(width: 28, height: 28)

            HStack(spacing: 4) {
                ForEach(0..<3) { i in
                    Circle()
                        .fill(AppColors.primary)
                        .frame(width: 6, height: 6)
                        .scaleEffect(animate ? 1 : 0.6)
                        .animation(
                            .easeInOut(duration: 0.6).repeatForever().delay(Double(i) * 0.15),
                            value: animate
                        )
                }
            }
            .padding(.horizontal, 14)
            .padding(.vertical, 12)
            .background(AppColors.background)
            .cornerRadius(16)
            .shadow(color: Color.black.opacity(0.03), radius: 3, x: 0, y: 1.5)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(AppColors.border.opacity(0.4), lineWidth: 1)
            )
            
            Spacer()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .onAppear { animate = true }
    }
}
