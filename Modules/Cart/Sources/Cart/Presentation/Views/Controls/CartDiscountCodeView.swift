import Common
import SwiftUI

struct CartDiscountCodeView: View {
    let codeText: String
    let appliedCode: String?
    let isApplying: Bool
    let errorMessage: String?
    let onTextChange: (String) -> Void
    let onApply: () -> Void
    let onRemove: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack(spacing: 10) {
                TextField(
                    CartText.discountCodePlaceholder,
                    text: Binding(
                        get: { displayedCode },
                        set: onTextChange
                    )
                )
                .disabled(isApplied)
                .font(.system(size: 15, weight: .semibold))
                .foregroundColor(AppColors.textPrimary)
                .frame(height: 44)

                Button(action: buttonAction) {
                    Text(buttonTitle)
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(buttonForegroundColor)
                        .frame(minWidth: 72)
                        .frame(height: 38)
                        .background(buttonBackgroundColor)
                        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                }
                .disabled(isButtonDisabled)
                .buttonStyle(.plain)
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 4)
            .background(AppColors.backgroundSecondary)
            .overlay(
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .stroke(borderColor, lineWidth: 1)
            )
            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))

            if let errorMessage, !errorMessage.isEmpty {
                Text(errorMessage)
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundColor(AppColors.error)
                    .padding(.horizontal, 4)
                    .transition(.opacity)
            }
        }
        .animation(.easeInOut(duration: 0.18), value: errorMessage)
        .animation(.easeInOut(duration: 0.18), value: isApplying)
        .animation(.easeInOut(duration: 0.18), value: appliedCode)
    }

    private var displayedCode: String {
        appliedCode ?? codeText
    }

    private var isApplied: Bool {
        appliedCode != nil
    }

    private var isButtonDisabled: Bool {
        isApplying || (!isApplied && codeText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
    }

    private var buttonTitle: String {
        if isApplying {
            return CartText.discountCodeApplyingTitle
        }

        return isApplied ? CartText.discountCodeRemoveTitle : CartText.discountCodeApplyTitle
    }

    private var buttonForegroundColor: Color {
        isButtonDisabled ? AppColors.textTertiary : AppColors.textWhite
    }

    private var buttonBackgroundColor: Color {
        isButtonDisabled ? AppColors.disabled : AppColors.primary
    }

    private var borderColor: Color {
        if errorMessage?.isEmpty == false {
            return AppColors.error
        }

        return AppColors.border
    }

    private func buttonAction() {
        if isApplied {
            onRemove()
        } else {
            onApply()
        }
    }
}
