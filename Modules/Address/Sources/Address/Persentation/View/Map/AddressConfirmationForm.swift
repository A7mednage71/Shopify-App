//
//  SwiftUIView.swift
//  
//
//  Created by Eyad waleed on 05/07/2026.
//
import SwiftUI
import Common
struct AddressConfirmationForm: View {
    @Binding var address: SelectedAddress
    @Environment(\.dismiss) private var dismiss
    var onAddAddress: (SelectedAddress) -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(L10n.Address.confirm)
                .font(AppFonts.title2)
                .foregroundColor(AppColors.textPrimary)

            VStack(alignment: .leading, spacing: 4) {
                Text(L10n.Address.addressField)
                    .font(AppFonts.caption)
                    .foregroundColor(AppColors.textSecondary)
                Text(address.fullAddress)
                    .font(AppFonts.body)
                    .foregroundColor(AppColors.textPrimary)
            }

            HStack(spacing: 16) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(L10n.Address.zipCode)
                        .font(AppFonts.caption)
                        .foregroundColor(AppColors.textSecondary)
                    TextField(L10n.Address.zipCode, text: $address.zipCode)
                        .textFieldStyle(.roundedBorder)
                        .keyboardType(.numberPad)
                        .foregroundColor(AppColors.textPrimary)
                }
                VStack(alignment: .leading, spacing: 4) {
                    Text(L10n.Address.country)
                        .font(AppFonts.caption)
                        .foregroundColor(AppColors.textSecondary)
                    TextField(L10n.Address.country, text: $address.country)
                        .textFieldStyle(.roundedBorder)
                        .foregroundColor(AppColors.textPrimary)
                }
            }

            Spacer()

            Button {
                onAddAddress(address)
                dismiss()
            } label: {
                Text(L10n.Address.addBtn)
                    .font(AppFonts.body)
                    .foregroundColor(AppColors.textWhite)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .background(AppColors.primary)
                    .cornerRadius(12)
            }
        }
        .padding(24)
        .background(AppColors.background.ignoresSafeArea())
    }
}
