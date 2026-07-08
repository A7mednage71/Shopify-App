import Common
import SwiftUI

struct PersonalInformationEditButton: View {
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            Label("Edit Information", systemImage: "pencil")
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

                    Text(isSaving ? "Saving..." : "Save Changes")
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
                Text("Cancel")
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
