import Common
import SwiftUI

struct PersonalInformationEditButton: View {
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            Label(L10n.Settings.editInformation, systemImage: "pencil")
                .font(AppFonts.callout.weight(.bold))
                .foregroundColor(AppColors.textWhite)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 14)
                .background(AppColors.primary)
                .cornerRadius(14)
        }
        .buttonStyle(.plain)
    }
}

struct PersonalInformationActionButtons: View {
    let isSaving: Bool
    let onSave: () -> Void
    let onCancel: () -> Void

    var body: some View {
        VStack(spacing: 10) {
            Button(action: onSave) {
                HStack(spacing: 8) {
                    if isSaving {
                        ProgressView()
                            .tint(AppColors.textWhite)
                    }

                    Text(isSaving ? L10n.Settings.saving : L10n.Settings.saveChanges)
                        .font(AppFonts.callout.weight(.bold))
                }
                .foregroundColor(AppColors.textWhite)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 14)
                .background(AppColors.primary)
                .cornerRadius(14)
            }
            .disabled(isSaving)
            .buttonStyle(.plain)

            Button(action: onCancel) {
                Text(L10n.Settings.cancel)
                    .font(AppFonts.callout.weight(.bold))
                    .foregroundColor(AppColors.textSecondary)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .background(AppColors.background)
                    .cornerRadius(14)
            }
            .disabled(isSaving)
            .buttonStyle(.plain)
        }
    }
}
