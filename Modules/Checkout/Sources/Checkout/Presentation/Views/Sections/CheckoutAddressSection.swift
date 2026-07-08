import Common
import SwiftUI

struct CheckoutAddressSection: View {
    let state: CheckoutAddressViewState
    let onAddAddressTap: () -> Void
    let onSelectedAddressTap: () -> Void

    init(
        state: CheckoutAddressViewState,
        onAddAddressTap: @escaping () -> Void = {},
        onSelectedAddressTap: @escaping () -> Void = {}
    ) {
        self.state = state
        self.onAddAddressTap = onAddAddressTap
        self.onSelectedAddressTap = onSelectedAddressTap
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            CheckoutSectionHeader(title: CheckoutText.addressTitle)

            switch state {
            case .loading:
                loadingView
            case .empty:
                emptyView
            case .success(let address):
                successView(address)
            case .failure(let message):
                failureView(message)
            }
        }
    }

    private var loadingView: some View {
        HStack(spacing: 14) {
            CheckoutShimmerBlock(height: 82, cornerRadius: 12)
                .frame(width: 136)

            VStack(alignment: .leading, spacing: 10) {
                CheckoutShimmerBlock(height: 18, cornerRadius: 7)
                    .frame(width: 110)
                CheckoutShimmerBlock(height: 14, cornerRadius: 7)
                    .frame(width: 170)
                CheckoutShimmerBlock(height: 14, cornerRadius: 7)
                    .frame(width: 140)
            }
        }
    }

    private var emptyView: some View {
        HStack(spacing: 14) {
            ZStack {
                RoundedRectangle(cornerRadius: 14, style: .continuous)
                    .fill(AppColors.backgroundSecondary)

                Image(systemName: "mappin.and.ellipse")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(AppColors.primary)
            }
            .frame(width: 86, height: 74)

            VStack(alignment: .leading, spacing: 6) {
                Text(CheckoutText.addressEmptyTitle)
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(AppColors.textPrimary)

                Text(CheckoutText.addressEmptyMessage)
                    .font(.system(size: 13, weight: .medium))
                    .foregroundColor(AppColors.textSecondary)
                    .fixedSize(horizontal: false, vertical: true)
            }

            Spacer(minLength: 8)

            Button(action: onAddAddressTap) {
                Image(systemName: "plus.circle.fill")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(AppColors.primary)
            }
            .buttonStyle(.plain)
            .accessibilityLabel(L10n.Checkout.addDeliveryAddressAccessibilityLabel)
        }
        .padding(14)
        .background(AppColors.backgroundSecondary)
        .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
    }

    private func successView(_ address: CheckoutAddress) -> some View {
        Button(action: onSelectedAddressTap) {
            HStack(spacing: 14) {
                mapThumbnail

                VStack(alignment: .leading, spacing: 6) {
                    Text(address.title)
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(AppColors.textPrimary)

                    Text(address.street)
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundColor(AppColors.textSecondary)

                    Text("\(address.city), \(address.region), \(address.postalCode)")
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundColor(AppColors.textSecondary)
                }

                Spacer(minLength: 8)

                Image(systemName: "chevron.right")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(AppColors.primary)
            }
        }
        .buttonStyle(.plain)
        .accessibilityLabel(L10n.Checkout.changeDeliveryAddressAccessibilityLabel)
    }

    private func failureView(_ message: String) -> some View {
        HStack(spacing: 12) {
            Image(systemName: "exclamationmark.triangle.fill")
                .font(.system(size: 22, weight: .bold))
                .foregroundColor(AppColors.error)

            VStack(alignment: .leading, spacing: 4) {
                Text(CheckoutText.addressFailureTitle)
                    .font(.system(size: 15, weight: .bold))
                    .foregroundColor(AppColors.textPrimary)

                Text(message.isEmpty ? CheckoutText.addressFailureFallbackMessage : message)
                    .font(.system(size: 13, weight: .medium))
                    .foregroundColor(AppColors.textSecondary)
            }
        }
        .padding(14)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(AppColors.backgroundSecondary)
        .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
    }

    private var mapThumbnail: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(AppColors.backgroundSecondary)

            VStack(spacing: 8) {
                HStack(spacing: 8) {
                    Capsule().fill(AppColors.textWhite.opacity(0.65)).frame(height: 8)
                    Capsule().fill(AppColors.primary.opacity(0.22)).frame(height: 8)
                }
                HStack(spacing: 8) {
                    Capsule().fill(AppColors.primary.opacity(0.22)).frame(height: 8)
                    Capsule().fill(AppColors.textWhite.opacity(0.65)).frame(height: 8)
                }
                HStack(spacing: 8) {
                    Capsule().fill(AppColors.textWhite.opacity(0.65)).frame(height: 8)
                    Capsule().fill(AppColors.primary.opacity(0.22)).frame(height: 8)
                }
            }
            .padding(12)

            ZStack {
                Circle()
                    .fill(AppColors.textWhite)
                    .frame(width: 34, height: 34)

                Image(systemName: "mappin.circle.fill")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(AppColors.error)
            }
        }
        .frame(width: 136, height: 82)
    }
}
