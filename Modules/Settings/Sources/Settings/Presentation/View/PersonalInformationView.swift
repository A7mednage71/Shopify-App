import Common
import SwiftUI

public struct PersonalInformationView: View {
    @State private var firstName: String = "Julianna"
    @State private var lastName: String = "Rossi"
    @State private var phone: String = "+1 234 567 890"
    @State private var email: String = "julianna.rossi@gmail.com"
    
    @State private var isSaving: Bool = false
    
    public init() {}
    
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
                        if isSaving {
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
                .disabled(isSaving)
                
            }
            .padding()
        }
        .background(Color(UIColor.systemGroupedBackground).edgesIgnoringSafeArea(.all))
        .navigationTitle(L10n.Settings.personalInfo)
        .navigationBarTitleDisplayMode(.inline)
    }

    private func saveChanges() {
        isSaving = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            isSaving = false
        }
    }
}


