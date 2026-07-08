import SwiftUI
import Common

struct CutomeCircularBtn: View {
    var image: String
    var label: String = ""
    var action: () -> Void

    private var isSystemImage: Bool {
        UIImage(systemName: image) != nil
    }

    var body: some View {
        Button {
            action()
        } label: {
            VStack(spacing: 0) {
                if isSystemImage {
                    Image(systemName: image)
                        .resizable()
                        .renderingMode(.template)
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                        .foregroundColor(AppColors.primary)
                } else {
                    Image(image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                }
                
                if !label.isEmpty {
                    Spacer()
                        .frame(height: 8)
                    
                    Text(label)
                        .font(AppFonts.footnote)
                        .foregroundColor(AppColors.textPrimary)
                        .lineLimit(1)
                        .minimumScaleFactor(0.4)
                        .padding(.horizontal, 4)
                }
            }
            .frame(width: 56, height: 56)
            .background(Color.white)
            .clipShape(Circle())
            .shadow(color: Color.black.opacity(0.08), radius: 6, x: 0, y: 3)
            .overlay(
                Circle()
                    .stroke(AppColors.authFieldBorder, lineWidth: 1)
            )
        }
    }
}
