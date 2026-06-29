//
//  SwiftUIView 2.swift
//  
//
//  Created by Esraa Ehab on 29/06/2026.
//

import SwiftUI

@available(iOS 14.0, *)
public struct RegisterView: View {
    @State var emailStateValue = ""
    @State var passwordStateValue = ""
    @State var confirmPasswordStateValue = ""
    
    @StateObject var viewModel = RegisterViewModel(
        registerUseCase: RegisterUseCase(authRepo: AuthenticationRepositarory(firebaseAuth: FirebaseAuthenitcation())),
        signInWithGoogle: SignWithGoogleUseCase(authRepo: AuthenticationRepositarory(firebaseAuth: FirebaseAuthenitcation()))
    )
    
    public init() {
        
    }
    
    public var body: some View {
        ZStack {
            formContent
            
            if viewModel.registerState == .loading {
                loadingOverlay
            }
        }
        .alert(isPresented: Binding(
            get: {
                if case .error(_) = viewModel.registerState { return true }
                return false
            },
            set: { _ in viewModel.registerState = .idel }
        )) {
            var errorMessage = ""
            if case .error(let msg) = viewModel.registerState {
                errorMessage = msg
            }
            return Alert(
                title: Text("Error"),
                message: Text(errorMessage),
                dismissButton: .default(Text("OK"))
            )
        }
    }
    
    @ViewBuilder
    private var formContent: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                Group {
                    Text("Create an\naccount")
                        .font(.system(size: 36, weight: .bold, design: .default))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 32)
                        .padding(.top, 20)
                    
                    Spacer().frame(height: 35)
                    
                    FormField(label: "Username or Email", icon: "person.fill", isError: !viewModel.emailError.isEmpty, formFieldState: $emailStateValue)
                    if !viewModel.emailError.isEmpty {
                        Text(viewModel.emailError)
                            .font(.system(size: 12))
                            .foregroundColor(.red)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 32)
                    }
                    
                    Spacer().frame(height: 15)
                    
                    FormField(label: "Password", icon: "lock.fill", isSecureField: true, isError: !viewModel.passwordError.isEmpty, formFieldState: $passwordStateValue)
                    if !viewModel.passwordError.isEmpty {
                        Text(viewModel.passwordError)
                            .font(.system(size: 12))
                            .foregroundColor(.red)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 32)
                    }
                }
                
                Group {
                    Spacer().frame(height: 15)
                    
                    FormField(label: "Confirm Password", icon: "lock.fill", isSecureField: true, isError: !viewModel.confirmPasswordError.isEmpty, formFieldState: $confirmPasswordStateValue)
                    if !viewModel.confirmPasswordError.isEmpty {
                        Text(viewModel.confirmPasswordError)
                            .font(.system(size: 12))
                            .foregroundColor(.red)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 32)
                    }
                    
                    Spacer().frame(height: 15)
                    
                    HStack(spacing: 0) {
                        Text("By clicking the ")
                            .foregroundColor(.gray)
                            .font(.system(size: 12))
                        Text("Register ")
                            .foregroundColor(Color(red: 255/255, green: 161/255, blue: 2/255))
                            .font(.system(size: 12))
                        Text("button, you agree\nto the public offer")
                            .foregroundColor(.gray)
                            .font(.system(size: 12))
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 32)
                    
                    Spacer().frame(height: 35)
                    
                    CustomBtn(label: "Create Account", action: {
                        Task {
                            await viewModel.register(email: emailStateValue, password: passwordStateValue, confirmPassword: confirmPasswordStateValue)
                        }
                    })
                    
                    Spacer().frame(height: 40)
                }
                
                Group {
                    Text("- OR Continue with -").font(.system(size: 12, design: .default))
                    
                    Spacer().frame(height: 25)
                    
                    HStack(spacing: 20) {
                        CutomeCircularBtn(image: "apple", action: {})
                        CutomeCircularBtn(image: "facebook", action: {})
                        CutomeCircularBtn(image: "google", action: {
                            Task {
                                await viewModel.registerWithGoogle()
                            }
                        })
                    }
                    
                    Spacer().frame(height: 28)
                    
                    HStack {
                        Text("I Already Have an Account").font(.system(size: 14))
                        Button { } label: {
                            Text("Login")
                                .font(.system(size: 14, weight: .bold))
                                .foregroundColor(Color(red: 255/255, green: 161/255, blue: 2/255))
                                .underline()
                        }
                    }
                    Spacer().frame(height: 20)
                }
            }
            .padding(.bottom, 20)
        }
        .disabled(viewModel.registerState == .loading) 
    }
    
    private var loadingOverlay: some View {
        ZStack {
            Color.black.opacity(0.3)
                .ignoresSafeArea()
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                .scaleEffect(1.5)
        }
    }
}
#Preview {
    RegisterView()
}
