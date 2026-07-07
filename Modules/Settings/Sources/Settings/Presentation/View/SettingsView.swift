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
    @StateObject private var viewModel = SettingsViewModel()
    private let onOrdersTap: () -> Void
    
    public init(onOrdersTap: @escaping () -> Void) {
            self.onOrdersTap = onOrdersTap
        }
    
    public var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 28) {
                    
                    Text("Profile")
                        .font(AppFonts.largeTitle)
                        .foregroundColor(AppColors.textPrimary)
                        .padding(.top, 10)
                        .frame(maxWidth: .infinity,alignment:.center)
                    
                    UserProfileCard(user: viewModel.user)
                    
                    SettingsSectionView(title: "Account Settings") {
                        SettingsActionRow(icon: "person", title: "Profile Information") {
                            print("Go to Profile Info")
                        }
                        Divider().background(AppColors.border)
                        SettingsActionRow(icon: "mappin.and.ellipse", title: "Saved Addresses") {
                            print("Go to Addresses")
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
                        viewModel.signOut()
                    }) {
                        Text("Sign Out")
                            .font(AppFonts.title3)
                            .foregroundColor(AppColors.error)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(AppColors.error.opacity(0.3), lineWidth: 1)
                            )
                    }
                    .padding(.top, 10)
                    .padding(.bottom, 40)
                    
                }
                .padding(.horizontal, 20)
            }
            .background(AppColors.backgroundSecondary.ignoresSafeArea())
            .navigationBarHidden(true)
        }
    }
}
