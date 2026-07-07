import SwiftUI
import Common

struct GlobalFloatingAssistantButton: View {
    let onTap: () -> Void

    @State private var position: CGPoint = .zero
    @State private var dragOffset: CGSize = .zero
    @State private var isDragActive = false
    @State private var isDragging = false

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Image(systemName: "bubble.left.and.bubble.right.fill")
                    .font(.system(size: 22, weight: .semibold))
                    .foregroundColor(.white)
                    .padding(16)
                    .background(
                        LinearGradient(
                            colors: [.appPrimaryOrange, .orange],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .clipShape(Circle())
                    .shadow(color: Color.appPrimaryOrange.opacity(0.4), radius: 8, x: 0, y: 4)
                    .scaleEffect(isDragActive || isDragging ? 1.15 : 1.0)
                    .opacity(isDragging ? 0.9 : 1.0)
                    .animation(.spring(response: 0.3, dampingFraction: 0.6), value: isDragActive || isDragging)
                    .overlay(
                        Circle()
                            .stroke(Color.white.opacity(isDragActive || isDragging ? 0.6 : 0.0), lineWidth: 2)
                    )
                    .position(
                        x: position.x + dragOffset.width,
                        y: position.y + dragOffset.height
                    )
                    .onLongPressGesture(minimumDuration: 0.4, pressing: { pressing in
                        withAnimation {
                            isDragActive = pressing
                        }
                    }, perform: {
                        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                        isDragActive = true
                    })
                    .gesture(
                        DragGesture(minimumDistance: 0)
                            .onChanged { value in
                                guard isDragActive else { return }
                                isDragging = true
                                dragOffset = value.translation
                            }
                            .onEnded { value in
                                if isDragActive && isDragging {
                                    let newX = position.x + value.translation.width
                                    let newY = position.y + value.translation.height
                                    snapToEdge(newX: newX, newY: newY, size: geometry.size)
                                } else if !isDragging {
                                    onTap()
                                }
                                dragOffset = .zero
                                isDragActive = false
                                isDragging = false
                            }
                    )
            }
            .onAppear {
                if position == .zero {
                    position = CGPoint(x: geometry.size.width - 44, y: geometry.size.height - 110)
                }
            }
        }
    }

    private func snapToEdge(newX: CGFloat, newY: CGFloat, size: CGSize) {
        let halfWidth = size.width / 2
        let paddingSide: CGFloat = 44 // distance from center of circle to edge of screen
        
        let targetX: CGFloat
        if newX < halfWidth {
            targetX = paddingSide
        } else {
            targetX = size.width - paddingSide
        }

        // Clamp Y to safe vertical boundaries (above tab bar, below notch/nav bar)
        let minY: CGFloat = 80
        let maxY: CGFloat = size.height - 110
        let targetY = min(max(newY, minY), maxY)

        withAnimation(.spring(response: 0.4, dampingFraction: 0.75)) {
            position = CGPoint(x: targetX, y: targetY)
        }
    }
}
