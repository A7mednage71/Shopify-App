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
    @ObservedObject private var localizationManager = LocalizationManager.shared
    @State private var isSignOutConfirmationPresented = false
    @State private var showLanguageAlert = false
    @State private var pendingLanguage = ""
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
                
                Text(L10n.Settings.profile)
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
                
                SettingsSectionView(title: L10n.Settings.accountSettings) {
                    SettingsActionRow(icon: "person", title: L10n.Settings.profileInformation) {
                        onPersonalInformationTap()
                    }
                    Divider().background(AppColors.border)
                    SettingsActionRow(icon: "mappin.and.ellipse", title: L10n.Settings.savedAddresses) {
                        onSavedAddressesTap()
                    }
                    Divider().background(AppColors.border)
                        
                        SettingsActionRow(icon: "shippingbox", title: L10n.Settings.orderHistory) {
                            onOrdersTap()
                        }
                }
                
                SettingsSectionView(title: L10n.Settings.regionalPreferences) {
                    HStack(spacing: 16) {
                        ZStack {
                            Circle().fill(AppColors.primary.opacity(0.1)).frame(width: 36, height: 36)
                            Image(systemName: "globe").foregroundColor(AppColors.primary)
                        }
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text(L10n.Settings.languageTitle)
                                .font(AppFonts.callout)
                                .foregroundColor(AppColors.textPrimary)
                            Text(localizationManager.currentLanguage.displayName)
                                .font(AppFonts.caption)
                                .foregroundColor(AppColors.textSecondary)
                        }
                        Spacer()
                        
                        let languageBinding = Binding<String>(
                            get: { localizationManager.appLanguage },
                            set: { newValue in
                                if newValue != localizationManager.appLanguage {
                                    pendingLanguage = newValue
                                    showLanguageAlert = true
                                }
                            }
                        )
                        
                        Picker("", selection: languageBinding) {
                            ForEach(AppLanguage.allCases) { lang in
                                Text(lang.displayName).tag(lang.rawValue)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        .accentColor(AppColors.textSecondary)
                    }
                    .padding(.vertical, 12)
                    .alert(isPresented: $showLanguageAlert) {
                        Alert(
                            title: Text(L10n.Settings.languageChangeTitle),
                            message: Text(L10n.Settings.languageChangeMessage),
                            primaryButton: .default(Text(L10n.Settings.languageChangeConfirm)) {
                                withAnimation(.easeInOut(duration: 0.6)) {
                                    localizationManager.appLanguage = pendingLanguage
                                }
                            },
                            secondaryButton: .cancel(Text(L10n.Main.cancel))
                        )
                    }
                    Divider().background(AppColors.border)
                    
                    HStack(spacing: 16) {
                        ZStack {
                            Circle().fill(AppColors.primary.opacity(0.1)).frame(width: 36, height: 36)
                            Image(systemName: "banknote").foregroundColor(AppColors.primary)
                        }
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text(L10n.Settings.currencyDisplay)
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
                
                SettingsSectionView(title: L10n.Settings.preferences) {
                    HStack(spacing: 16) {
                        ZStack {
                            Circle().fill(AppColors.primary.opacity(0.1)).frame(width: 36, height: 36)
                            Image(systemName: "moon.fill").foregroundColor(AppColors.primary)
                        }
                        VStack(alignment: .leading, spacing: 4) {
                            Text(L10n.Settings.darkMode)
                                .font(AppFonts.callout)
                                .foregroundColor(AppColors.textPrimary)
                            Text(L10n.Settings.systemDefault)
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
                    HStack(spacing: 12) {
                        ZStack {
                            Circle()
                                .fill(AppColors.error.opacity(0.12))
                                .frame(width: 36, height: 36)

                            if viewModel.isSigningOut {
                                ProgressView()
                                    .tint(AppColors.error)
                            } else {
                                Image(systemName: "rectangle.portrait.and.arrow.right")
                                    .font(.system(size: 16, weight: .semibold))
                                    .foregroundColor(AppColors.error)
                            }
                        }

                        Text(viewModel.isSigningOut ? L10n.Settings.signingOut : L10n.Settings.signOut)
                            .font(AppFonts.callout.weight(.semibold))
                            .foregroundColor(AppColors.error)

                        Spacer()
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 14)
                    .background(AppColors.error.opacity(0.08))
                    .overlay(
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .stroke(AppColors.error.opacity(0.18), lineWidth: 1)
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                }
                .disabled(viewModel.isSigningOut)
                .padding(.top, 10)
                .padding(.bottom, 40)
                
            }
            .padding(.horizontal, 20)
        }
        .background(AppColors.backgroundSecondary.ignoresSafeArea())
        .navigationBarHidden(true)
        .task {
            await profileDataViewModel.loadProfileIfNeeded()
        }
        .alert(L10n.Settings.signOutConfirmTitle, isPresented: $isSignOutConfirmationPresented) {
            Button(L10n.Settings.cancel, role: .cancel) {}
            Button(L10n.Settings.signOut, role: .destructive) {
                Task {
                    await viewModel.signOut()
                }
            }
        } message: {
            Text(L10n.Settings.signOutConfirmMessage)
        }
        .alert(L10n.Settings.signOutErrorTitle, isPresented: signOutErrorBinding) {
            Button(L10n.Settings.ok, role: .cancel) {
                viewModel.signOutErrorMessage = nil
            }
        } message: {
            Text(viewModel.signOutErrorMessage ?? L10n.Settings.tryAgain)
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
