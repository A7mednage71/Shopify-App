//
//  SwiftUIView.swift
//  
//
//  Created by Esraa Ehab on 02/07/2026.
//

import SwiftUI
import Common

@available(iOS 14.0, *)
public struct SettingsView: View {
    @StateObject private var viewModel: SettingsViewModel
    @ObservedObject private var profileDataViewModel: ProfileDataViewModel
    @State private var isSignOutConfirmationPresented = false
    private let onPersonalInformationTap: () -> Void
    private let onSavedAddressesTap: () -> Void
    private let onOrdersTap: () -> Void
    
    public init(
        viewModel: SettingsViewModel,
        onPersonalInformationTap: @escaping () -> Void = {},
        onSavedAddressesTap: @escaping () -> Void = {},
        onOrdersTap: @escaping () -> Void = {}
    ) {
        self._viewModel = StateObject(wrappedValue: viewModel)
        self.profileDataViewModel = viewModel.profileDataViewModel
        self.onPersonalInformationTap = onPersonalInformationTap
        self.onSavedAddressesTap = onSavedAddressesTap
        self.onOrdersTap = onOrdersTap
    }
    
    public var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 28) {
                
                Text("Profile")
                    .font(AppFonts.title1)
                    .foregroundColor(AppColors.textPrimary)
                    .padding(.top, 10)
                    .frame(maxWidth: .infinity, alignment: .center)
                
                UserProfileCard(
                    state: profileDataViewModel.state,
                    onRetry: {
                        Task {
                            await profileDataViewModel.loadProfile()
                        }
                    },
                    onEdit: onPersonalInformationTap
                )
                
                SettingsSectionView(title: "Account Settings") {
                    SettingsActionRow(icon: "person", title: "Profile Information") {
                        onPersonalInformationTap()
                    }
                    Divider().background(AppColors.border)
                    SettingsActionRow(icon: "mappin.and.ellipse", title: "Saved Addresses") {
                        onSavedAddressesTap()
                    }
                    Divider().background(AppColors.border)
                        
                        SettingsActionRow(icon: "shippingbox", title: "Order History") {
                            onOrdersTap()
                        }
                }
                
                SettingsSectionView(title: "Regional Preferences") {
                    SettingsActionRow(icon: "globe", title: "Language", subtitle: "English (United Kingdom)") {
                        print("Change Language")
                    }
                    Divider().background(AppColors.border)
                    
                    HStack(spacing: 16) {
                        ZStack {
                            Circle().fill(AppColors.primary.opacity(0.1)).frame(width: 36, height: 36)
                            Image(systemName: "banknote").foregroundColor(AppColors.primary)
                        }
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Currency Display")
                                .font(AppFonts.callout)
                                .foregroundColor(AppColors.textPrimary)
                            Text(viewModel.selectedCurrency.rawValue)
                                .font(AppFonts.caption)
                                .foregroundColor(AppColors.textSecondary)
                        }
                        Spacer()
                        
                        Picker("", selection: $viewModel.selectedCurrency) {
                            ForEach(AppCurrency.allCases) { currency in
                                Text(currency.rawValue).tag(currency)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        .accentColor(AppColors.textSecondary)
                    }
                    .padding(.vertical, 12)
                }
                
                SettingsSectionView(title: "Preferences") {
                    HStack(spacing: 16) {
                        ZStack {
                            Circle().fill(AppColors.primary.opacity(0.1)).frame(width: 36, height: 36)
                            Image(systemName: "moon.fill").foregroundColor(AppColors.primary)
                        }
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Dark Mode")
                                .font(AppFonts.callout)
                                .foregroundColor(AppColors.textPrimary)
                            Text("System Default")
                                .font(AppFonts.caption)
                                .foregroundColor(AppColors.textSecondary)
                        }
                        Spacer()
                        Toggle("", isOn: $viewModel.isDarkMode)
                            .toggleStyle(SwitchToggleStyle(tint: AppColors.primary))
                    }
                    .padding(.vertical, 12)
                }
                
                Button(action: {
                    isSignOutConfirmationPresented = true
                }) {
                    HStack(spacing: 8) {
                        if viewModel.isSigningOut {
                            ProgressView()
                                .tint(AppColors.error)
                        }

                        Text(viewModel.isSigningOut ? "Signing Out..." : "Sign Out")
                            .font(AppFonts.title3)
                    }
                    .foregroundColor(AppColors.error)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(AppColors.error.opacity(0.3), lineWidth: 1)
                    )
                }
                .disabled(viewModel.isSigningOut)
                .padding(.top, 10)
                .padding(.bottom, 40)
                
            }
            .padding(.horizontal, 20)
        }
        .background(AppColors.backgroundSecondary.ignoresSafeArea())
        .settingsNavigationBarHidden(true)
        .task {
            await profileDataViewModel.loadProfileIfNeeded()
        }
        .alert("Sign out?", isPresented: $isSignOutConfirmationPresented) {
            Button("Cancel", role: .cancel) {}
            Button("Sign Out", role: .destructive) {
                Task {
                    await viewModel.signOut()
                }
            }
        } message: {
            Text("Are you sure you want to sign out?")
        }
        .alert("Could not sign out", isPresented: signOutErrorBinding) {
            Button("OK", role: .cancel) {
                viewModel.signOutErrorMessage = nil
            }
        } message: {
            Text(viewModel.signOutErrorMessage ?? "Please try again.")
        }
    }

    private var signOutErrorBinding: Binding<Bool> {
        Binding(
            get: { viewModel.signOutErrorMessage != nil },
            set: { isPresented in
                if !isPresented {
                    viewModel.signOutErrorMessage = nil
                }
            }
        )
    }
}
