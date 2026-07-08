import SwiftUI

@available(iOS 16.0, *)
public struct ProductReviewSheet: View {
    @Environment(\.dismiss) private var dismiss
    @State private var rating = 0
    @State private var title = ""
    @State private var bodyText = ""
    @State private var isSubmitting = false
    @State private var errorMessage: String?
    @State private var successMessage: String?

    public let productTitle: String
    public let onSubmit: (ProductReviewInput) async throws -> Void
    public let productID: String?

    public init(
        productTitle: String,
        onSubmit: @escaping (ProductReviewInput) async throws -> Void,
        productID: String?
    ) {
        self.productTitle = productTitle
        self.onSubmit = onSubmit
        self.productID = productID
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Capsule()
                .fill(AppColors.border)
                .frame(width: 42, height: 5)
                .frame(maxWidth: .infinity)
                .padding(.top, 8)

            VStack(alignment: .leading, spacing: 6) {
                Text("Review product")
                    .font(.system(size: 22, weight: .bold))
                    .foregroundColor(AppColors.textPrimary)

                Text(productTitle)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(AppColors.textSecondary)
                    .lineLimit(2)
            }

            VStack(alignment: .leading, spacing: 10) {
                Text("Your rating")
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

            TextField("Review title", text: $title)
                .font(.system(size: 15, weight: .semibold))
                .textFieldStyle(.plain)
                .padding(.horizontal, 14)
                .frame(height: 48)
                .background(AppColors.backgroundSecondary)
                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))

            TextField("Tell us what you liked", text: $bodyText, axis: .vertical)
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

            // Submit Button
            Button(action: submit) {
                Text(isSubmitting ? "Submitting..." : "Submit review")
                    .font(.system(size: 17, weight: .bold))
                    .foregroundColor(AppColors.textWhite)
                    .frame(maxWidth: .infinity)
                    .frame(height: 58)
                    .background(isSubmitting || productID == nil ? AppColors.textSecondary : AppColors.primary)
                    .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
                    .shadow(color: (isSubmitting || productID == nil ? Color.clear : AppColors.primary.opacity(0.28)), radius: 16, x: 0, y: 10)
            }
            .disabled(isSubmitting || productID == nil)
            .buttonStyle(PrimaryButtonStyle())
            .accessibilityLabel(isSubmitting ? "Submitting..." : "Submit review")
        }
        .padding(.horizontal, 22)
        .padding(.bottom, 24)
        .background(AppColors.background.ignoresSafeArea())
        .presentationDetents([.medium, .large])
        .presentationDragIndicator(.hidden)
    }

    private func submit() {
        guard let productID else {
            errorMessage = "Product not found."
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

                successMessage = "Thanks for your review."

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

private struct PrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.98 : 1)
            .animation(.easeInOut(duration: 0.12), value: configuration.isPressed)
    }
}
