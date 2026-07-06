import Common
import SwiftUI

struct CheckoutReviewSheet: View {
    @Environment(\.dismiss) private var dismiss
    @State private var rating = 0
    @State private var title = ""
    @State private var bodyText = ""
    @State private var isSubmitting = false
    @State private var errorMessage: String?
    @State private var successMessage: String?

    let productTitle: String
    let onSubmit: (ProductReviewInput) async throws -> Void
    let productID: String?

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Capsule()
                .fill(AppColors.border)
                .frame(width: 42, height: 5)
                .frame(maxWidth: .infinity)
                .padding(.top, 8)

            VStack(alignment: .leading, spacing: 6) {
                Text(CheckoutText.reviewSheetTitle)
                    .font(.system(size: 22, weight: .bold))
                    .foregroundColor(AppColors.textPrimary)

                Text(productTitle)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(AppColors.textSecondary)
                    .lineLimit(2)
            }

            VStack(alignment: .leading, spacing: 10) {
                Text(CheckoutText.reviewRatingTitle)
                    .font(.system(size: 15, weight: .bold))
                    .foregroundColor(AppColors.textPrimary)

                HStack(spacing: 8) {
                    ForEach(1...5, id: \.self) { star in
                        Button {
                            rating = star
                            errorMessage = nil
                        } label: {
                            Image(systemName: star <= rating ? "star.fill" : "star")
                                .font(.system(size: 30, weight: .bold))
                                .foregroundColor(AppColors.primary)
                        }
                        .buttonStyle(.plain)
                    }
                }
            }

            TextField(CheckoutText.reviewTitlePlaceholder, text: $title)
                .font(.system(size: 15, weight: .semibold))
                .textFieldStyle(.plain)
                .padding(.horizontal, 14)
                .frame(height: 48)
                .background(AppColors.backgroundSecondary)
                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))

            TextField(CheckoutText.reviewBodyPlaceholder, text: $bodyText, axis: .vertical)
                .font(.system(size: 15, weight: .semibold))
                .lineLimit(4...6)
                .textFieldStyle(.plain)
                .padding(.horizontal, 14)
                .padding(.vertical, 12)
                .background(AppColors.backgroundSecondary)
                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))

            if let successMessage {
                Text(successMessage)
                    .font(.system(size: 13, weight: .bold))
                    .foregroundColor(AppColors.success)
            } else if let errorMessage {
                Text(errorMessage)
                    .font(.system(size: 13, weight: .bold))
                    .foregroundColor(AppColors.error)
            }

            CheckoutPrimaryButton(
                title: isSubmitting
                    ? CheckoutText.submittingReviewButtonTitle
                    : CheckoutText.submitReviewButtonTitle,
                isDisabled: isSubmitting || productID == nil,
                action: submit
            )
        }
        .padding(.horizontal, 22)
        .padding(.bottom, 24)
        .background(AppColors.background.ignoresSafeArea())
        .presentationDetents([.medium, .large])
        .presentationDragIndicator(.hidden)
    }

    private func submit() {
        guard let productID else {
            errorMessage = CheckoutError.unknown.localizedDescription
            return
        }

        isSubmitting = true
        errorMessage = nil
        successMessage = nil

        Task {
            do {
                try await onSubmit(
                    ProductReviewInput(
                        productId: productID,
                        rating: rating,
                        title: title,
                        body: bodyText
                    )
                )

                successMessage = CheckoutText.reviewSubmittedMessage

                DispatchQueue.main.asyncAfter(deadline: .now() + 0.45) {
                    dismiss()
                }
            } catch {
                errorMessage = error.localizedDescription
            }

            isSubmitting = false
        }
    }
}
