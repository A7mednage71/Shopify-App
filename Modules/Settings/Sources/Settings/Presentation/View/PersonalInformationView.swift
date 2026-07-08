import Common
import SwiftUI

public struct PersonalInformationView: View {
    @StateObject private var viewModel: ProfileDataViewModel
    
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var phone: String = ""
    @State private var email: String = ""
    
    public init(viewModel: ProfileDataViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    public var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                
                Image("marketek", bundle: .module)
                    .resizable()
                    .frame(width: 50, height: 50)
                    .cornerRadius(10)
                
                Text(L10n.Settings.profileInformationTitle)
                    .font(AppFonts.title1).bold()
                
                Text(L10n.Settings.profileSubtitle)
                    .multilineTextAlignment(.center)
                     .font(AppFonts.callout)
                     .foregroundColor(AppColors.primary)
                
                VStack(spacing: 0) {
                    CustomTextFieldRow(icon: "person.fill", title: L10n.Settings.firstName, text: $firstName, placeholder: L10n.Settings.enterFirstName)
                    
                    Divider().padding(.leading, 48) 
                    
                    CustomTextFieldRow(icon: "person", title: L10n.Settings.lastName, text: $lastName, placeholder: L10n.Settings.enterLastName)
                }
                .background(Color.white)
                .cornerRadius(12)
                
                VStack(spacing: 0) {
                    CustomTextFieldRow(icon: "phone.fill", title: L10n.Settings.phone, text: $phone, placeholder: L10n.Settings.enterPhoneNumber, keyboardType: .phonePad)
                    
                    Divider().padding(.leading, 48)
                    
                    HStack(spacing: 12) {
                        Image(systemName: "envelope.fill")
                            .foregroundColor(.gray.opacity(0.8))
                            .frame(width: 24) 
                        
                        Text(L10n.Settings.email)
                            .foregroundColor(.gray)
                            .frame(width: 90, alignment: .leading)
                        
                        Text(email)
                            .foregroundColor(.gray.opacity(0.8))
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding()
                }
                .background(Color.white)
                .cornerRadius(12)
                
                Button(action: {
                    saveChanges()
                }) {
                    HStack {
                        if viewModel.isSaving {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                .padding(.trailing, 8)
                        }
                        Text(L10n.Settings.saveChanges)
                            .font(.headline)
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 54)
                    .foregroundColor(.white)
                    .background(Color.orange)
                    .cornerRadius(27)
                    .padding(.top, 16)
                }
                .disabled(viewModel.isSaving)
                
            }
            .padding()
        }
        .background(Color(UIColor.systemGroupedBackground).edgesIgnoringSafeArea(.all))
        .navigationTitle(L10n.Settings.personalInfo)
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await viewModel.loadProfileIfNeeded()
        }
        .onReceive(viewModel.$state) { state in
            if case .success(let profile) = state {
                firstName = profile.firstName ?? ""
                lastName = profile.lastName ?? ""
                phone = profile.phone ?? ""
                email = profile.email ?? ""
            }
        }
    }

    private func saveChanges() {
        Task {
            await viewModel.updateProfile(CustomerProfileUpdateInput(
                firstName: firstName,
                lastName: lastName,
                phone: phone
            ))
        }
    }
}


