import SwiftUI
import Common

@available(iOS 15.0, *)
struct FormField: View {
    var label: String
    var icon: String
    var isSecureField: Bool = false
    var isError: Bool = false
    @Binding var formFieldState: String
    
    @State private var isSecure: Bool = true
    @FocusState private var isFocused: Bool
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(isError ? AppColors.error : (isFocused ? AppColors.primary : AppColors.textSecondary))
                .frame(width: 24)
            
            if isSecureField && isSecure {
                SecureField(label, text: $formFieldState)
                    .focused($isFocused)
                    .font(.system(size: 16))
            } else {
                TextField(label, text: $formFieldState)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .focused($isFocused)
                    .font(.system(size: 16))
            }
            
            if isSecureField {
                Button {
                    isSecure.toggle()
                } label: {
                    Image(systemName: isSecure ? "eye.slash.fill" : "eye.fill")
                        .font(.system(size: 16))
                        .foregroundColor(isError ? AppColors.error : (isFocused ? AppColors.primary : AppColors.textSecondary))
                }
            }
        }
        .padding(.vertical, 16)
        .padding(.horizontal, 20)
        .background(isFocused ? Color.white : AppColors.authFieldBackground)
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(
                    isError ? AppColors.error : (isFocused ? AppColors.primary : AppColors.authFieldBorder),
                    lineWidth: 1.5
                )
        )
        .padding(.horizontal, 32)
        .animation(.easeInOut(duration: 0.2), value: isFocused)
    }
}
