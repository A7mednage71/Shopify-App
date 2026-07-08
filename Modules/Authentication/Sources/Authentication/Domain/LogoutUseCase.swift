import Foundation
import Common




@available(iOS 13.0.0, *)
public final class LogoutUseCase : LogoutUseCaseProtocol {
    private let authRepo: AuthRepoInterface

    init(authRepo: AuthRepoInterface) {
        self.authRepo = authRepo
    }

    public func execute() async throws {
        try await authRepo.signOut()
    }
}
