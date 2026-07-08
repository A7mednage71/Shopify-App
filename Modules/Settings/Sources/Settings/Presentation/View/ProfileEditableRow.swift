import Common
import SwiftUI

struct ProfileEditableRow: View {
    let icon: String
    let title: String
    @Binding var text: String
    var keyboardType: SettingsKeyboardKind = .default
    var textInputAutocapitalization: SettingsTextAutocapitalizationKind = .words

    var body: some View {
        HStack(spacing: 14) {
            Image(systemName: icon)
                .font(.system(size: 15, weight: .semibold))
                .foregroundColor(AppColors.primary)
                .frame(width: 24)

            VStack(alignment: .leading, spacing: 5) {
                Text(title)
                    .font(AppFonts.caption.weight(.semibold))
                    .foregroundColor(AppColors.textSecondary)

                TextField(title, text: $text)
                    .font(AppFonts.callout.weight(.semibold))
                    .foregroundColor(AppColors.textPrimary)
                    .settingsKeyboardType(keyboardType)
                    .settingsTextInputAutocapitalization(textInputAutocapitalization)
            }
        }
        .padding(.vertical, 12)
    }
}
