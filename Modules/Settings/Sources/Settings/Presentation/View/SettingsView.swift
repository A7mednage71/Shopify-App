//
//  SwiftUIView.swift
//  
//
//  Created by Esraa Ehab on 02/07/2026.
//

import SwiftUI

@available(iOS 14.0, *)
public struct SettingsView: View {
    @StateObject private var viewModel = SettingsViewModel()
    
    let backgroundColor = Color(red: 250/255, green: 245/255, blue: 239/255)
    let primaryOrange = Color(red: 255/255, green: 161/255, blue: 2/255)
    
    public init() {}
    
    public var body: some View {
            NavigationView {
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 28) {
                        
                        Text("Profile")
                            .font(.system(size: 34, weight: .bold))
                            .padding(.top, 10)
                            .frame(maxWidth: .infinity,alignment:.center)
                        
                        UserProfileCard(user: viewModel.user)
                        
                        SettingsSectionView(title: "Account Settings") {
                            SettingsActionRow(icon: "person", title: "Profile Information") {
                                print("Go to Profile Info")
                            }
                            Divider()
                            SettingsActionRow(icon: "mappin.and.ellipse", title: "Saved Addresses") {
                                print("Go to Addresses")
                            }
                        }
                        
                        SettingsSectionView(title: "Regional Preferences") {
                            SettingsActionRow(icon: "globe", title: "Language", subtitle: "English (United Kingdom)") {
                                print("Change Language")
                            }
                            Divider()
                            
                            HStack(spacing: 16) {
                                ZStack {
                                    Circle().fill(primaryOrange.opacity(0.1)).frame(width: 36, height: 36)
                                    Image(systemName: "banknote").foregroundColor(primaryOrange)
                                }
                                
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("Currency Display")
                                        .font(.system(size: 16))
                                    Text(viewModel.selectedCurrency.rawValue)
                                        .font(.system(size: 12))
                                        .foregroundColor(.gray)
                                }
                                Spacer()
                                
                                Picker("", selection: $viewModel.selectedCurrency) {
                                    ForEach(AppCurrency.allCases) { currency in
                                        Text(currency.rawValue).tag(currency)
                                    }
                                }
                                .pickerStyle(MenuPickerStyle())
                                .accentColor(.gray)
                            }
                            .padding(.vertical, 12)
                        }
                        
                        SettingsSectionView(title: "Preferences") {
                            HStack(spacing: 16) {
                                ZStack {
                                    Circle().fill(primaryOrange.opacity(0.1)).frame(width: 36, height: 36)
                                    Image(systemName: "moon.fill").foregroundColor(primaryOrange)
                                }
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("Dark Mode")
                                        .font(.system(size: 16))
                                    Text("System Default")
                                        .font(.system(size: 12))
                                        .foregroundColor(.gray)
                                }
                                Spacer()
                                Toggle("", isOn: $viewModel.isDarkMode)
                                    .accentColor(primaryOrange)
                            }
                            .padding(.vertical, 12)
                            
                            Divider()
                            
                            SettingsActionRow(icon: "textformat", title: "Language") {
                                print("App Language")
                            }
                        }
                        
                        Button(action: {
                            viewModel.signOut()
                        }) {
                            Text("Sign Out")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(.red)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 16)
                                .background(
                                    RoundedRectangle(cornerRadius: 16)
                                        .stroke(Color.red.opacity(0.3), lineWidth: 1)
                                )
                        }
                        .padding(.top, 10)
                        .padding(.bottom, 40)
                        
                    }
                    .padding(.horizontal, 20)
                }
                .background(backgroundColor.ignoresSafeArea())
                .preferredColorScheme(viewModel.isDarkMode ? .dark : .light)
                .navigationBarHidden(true)
            }
        }
    }

      @available(iOS 14.0, *)
    struct SettingsView_Previews: PreviewProvider {
        static var previews: some View {
            SettingsView()
        }
    }
