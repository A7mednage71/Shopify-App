//
//  File.swift
//  
//
//  Created by Eyad waleed on 07/07/2026.
//

import Foundation
import Swinject
import Foundation
import Swinject
@MainActor
public final class AuthAssembly: Assembly {
    
    public init() {}
    
    public func assemble(container: Container) {
        
        
        container.register(AuthenticationService.self) { _ in
            ApiAuth.shared
        }
        .inObjectScope(.container)
        
        container.register(AuthenticationServiceViaPlatform.self) { _ in
            FirebaseAuthenitcation()
        }
        .inObjectScope(.container)
        
        
        container.register(AuthRepoInterface.self) { resolver in
            AuthenticationRepositarory(
                firebaseAuth: resolver.resolve(AuthenticationServiceViaPlatform.self)!,
                apiAuth: resolver.resolve(AuthenticationService.self)!
            )
        }
        .inObjectScope(.container)
        
        
        container.register(SignInUseCase.self) { resolver in
            SignInUseCase(Authrepo: resolver.resolve(AuthRepoInterface.self)!)
        }
        
        container.register(SignWithGoogleUseCase.self) { resolver in
            SignWithGoogleUseCase(authRepo: resolver.resolve(AuthRepoInterface.self)!)
        }
        
        container.register(RegisterUseCase.self) { resolver in
            RegisterUseCase(authRepo: resolver.resolve(AuthRepoInterface.self)!)
        }
        
        container.register(LoginViewModel.self) { resolver in
            LoginViewModel(
                signIn: resolver.resolve(SignInUseCase.self)!,
                signInWithGoogle: resolver.resolve(SignWithGoogleUseCase.self)!
            )
        }
        container.register(RegisterViewModel.self) { resolver in
            RegisterViewModel(
                registerUseCase: resolver.resolve(RegisterUseCase.self)!,
                signInWithGoogle: resolver.resolve(SignWithGoogleUseCase.self)!
            )
        }
        container.register(AuthViewFactory.self) { _ in
            DefaultAuthViewFactory()
        }
    }
}
