//
//  File.swift
//  
//
//  Created by Eyad waleed on 28/06/2026.
//

import Foundation
@available(iOS 13.0.0, *)
class SignWithGoogleUseCase {
    var authRepo : AuthRepoInterface
    init(authRepo: AuthRepoInterface) {
        self.authRepo = authRepo
    }
    func execute() async throws {
        try await authRepo.signInByGoogle()
    }
}
