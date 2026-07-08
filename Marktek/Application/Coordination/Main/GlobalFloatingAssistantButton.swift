import SwiftUI
import Common

struct GlobalFloatingAssistantButton: View {
    let onTap: () -> Void

    private enum Layout {
        static let buttonRadius: CGFloat = 44
        static let topSafeMargin: CGFloat = 80
        static let bottomSafeMargin: CGFloat = 110
        static let tapDistanceThreshold: CGFloat = 15
    }

    @AppStorage("assistantButtonOnLeftSide") private var isOnLeftSide: Bool = false
    @AppStorage("assistantButtonY") private var savedY: Double = -1

    @State private var position: CGPoint = .zero
    @State private var dragOffset: CGSize = .zero
    @State private var isDragging = false
    @State private var isPulsing = false

    @Environment(\.layoutDirection) private var layoutDirection

    private var currentPosition: CGPoint {
        let xOffset = layoutDirection == .rightToLeft ? -dragOffset.width : dragOffset.width
        return CGPoint(x: position.x + xOffset, y: position.y + dragOffset.height)
    }

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Circle()
                    .stroke(
                        LinearGradient(
                            colors: [.appPrimaryOrange.opacity(0.6), .appPrimaryPink.opacity(0.1)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        lineWidth: 3
                    )
                    .frame(width: 56, height: 56)
                    .scaleEffect(isPulsing ? 1.45 : 1.0)
                    .opacity(isPulsing ? 0.0 : 1.0)
                    .position(currentPosition)
                    .allowsHitTesting(false)

                ZStack {
                    Image(systemName: "bubble.left.and.bubble.right.fill")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.white)

                    Image(systemName: "sparkles")
                        .font(.system(size: 11, weight: .bold))
                        .foregroundColor(.white)
                        .offset(x: 10, y: -10)
                        .shadow(color: .white.opacity(0.8), radius: 2)
                }
                .padding(16)
                .background(
                    LinearGradient(
                        colors: [.appPrimaryOrange, .appPrimaryPink],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .clipShape(Circle())
                .shadow(color: Color.appPrimaryOrange.opacity(0.35), radius: 10, x: 0, y: 6)
                .scaleEffect(isDragging ? 1.15 : 1.0)
                .opacity(isDragging ? 0.9 : 1.0)
                .animation(.spring(response: 0.3, dampingFraction: 0.6), value: isDragging)
                .overlay(
                    Circle()
                        .stroke(
                            LinearGradient(
                                colors: [.white.opacity(0.6), .white.opacity(0.2)],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ),
                            lineWidth: 2
                        )
                )
                .position(currentPosition)
                .gesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged { value in
                            isDragging = true
                            dragOffset = value.translation
                        }
                        .onEnded { value in
                            let distance = sqrt(pow(value.translation.width, 2) + pow(value.translation.height, 2))

                            if distance < Layout.tapDistanceThreshold {
                                UIImpactFeedbackGenerator(style: .light).impactOccurred()
                                onTap()
                            } else {
                                let xDelta = layoutDirection == .rightToLeft ? -value.translation.width : value.translation.width
                                let newX = position.x + xDelta
                                let newY = position.y + value.translation.height
                                snapToEdge(newX: newX, newY: newY, size: geometry.size)
                            }

                            withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                                dragOffset = .zero
                                isDragging = false
                            }
                        }
                )
            }
            .onAppear {
                let screenWidth = geometry.size.width
                let yPos = savedY >= 0
                    ? savedY
                    : geometry.size.height - Layout.bottomSafeMargin

                let xPos: CGFloat = isOnLeftSide ? Layout.buttonRadius : screenWidth - Layout.buttonRadius

                position = CGPoint(x: xPos, y: yPos)

                withAnimation(.easeInOut(duration: 2.0).repeatForever(autoreverses: false)) {
                    isPulsing = true
                }
            }
            .onChange(of: geometry.size) { newSize in
                snapToEdge(newX: position.x, newY: position.y, size: newSize)
            }
        }
    }

    private func snapToEdge(newX: CGFloat, newY: CGFloat, size: CGSize) {
        let halfWidth = size.width / 2
        let targetY = min(max(newY, Layout.topSafeMargin), size.height - Layout.bottomSafeMargin)

        let onLeft = newX < halfWidth
        let targetX: CGFloat = onLeft ? Layout.buttonRadius : size.width - Layout.buttonRadius

        withAnimation(.spring(response: 0.4, dampingFraction: 0.75)) {
            position = CGPoint(x: targetX, y: targetY)
        }

        isOnLeftSide = onLeft
        savedY = targetY
    }
}
