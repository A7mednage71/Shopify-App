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
                        .frame(width: 22, height: 22)
                        .foregroundColor(AppColors.primary)
                } else {
                    Image(image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 22, height: 22)
                }
                
                
                if !label.isEmpty {
                    Spacer()
                        .frame(height: 8)
                    
                    Text(label)
                        .font(.system(size: 10, weight: .semibold))
                        .foregroundColor(AppColors.textPrimary)
                        .lineLimit(1)
                        .minimumScaleFactor(0.4)
                        .padding(.horizontal, 4)
                }
            }
            .frame(width: 56, height: 56)
            .background(Color.appOrangeShadow)
            .clipShape(Circle())
            .overlay(
                Circle()
                    .stroke(AppColors.primary, lineWidth: 1)
            )
        }
    }
  
}
