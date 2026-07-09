import XCTest
import Common
@testable import Authentication

@available(iOS 16.0, *)
final class AuthenticationTests: XCTestCase {
    
    // MARK: - Mocks
    
    class MockAuthRepo: AuthRepoInterface {
        var signInCalled = false
        var signInEmail: String?
        var signInPassword: String?
        var signInError: Error?

        func signIn(email: String, password: String) async throws {
            signInCalled = true
            signInEmail = email
            signInPassword = password
            if let error = signInError {
                throw error
            }
        }

        var signInByGoogleCalled = false
        func signInByGoogle() async throws {
            signInByGoogleCalled = true
        }

        var createUserCalled = false
        var createUserEmail: String?
        var createUserPassword: String?
        var createUserFirstName: String?
        var createUserLastName: String?
        var createUserError: Error?

        func createUserWithEmailAndPassword(email: String, password: String, firstName: String, lastName: String) async throws {
            createUserCalled = true
            createUserEmail = email
            createUserPassword = password
            createUserFirstName = firstName
            createUserLastName = lastName
            if let error = createUserError {
                throw error
            }
        }

        var signOutCalled = false
        func signOut() async throws {
            signOutCalled = true
        }
    }
    
    // MARK: - Boilerplate Tests
    
    func testExample() throws {
        XCTAssertEqual(Authentication().text, "Hello, World!")
    }
    
    // MARK: - SignInUseCase Tests
    
    func testSignIn_WithEmptyEmail_ShouldThrowEmailEmptyError() async {
        // Given
        let repo = MockAuthRepo()
        let useCase = SignInUseCase(Authrepo: repo)
        
        // When/Then
        do {
            try await useCase.execute(email: "", password: "password123")
            XCTFail("Should throw ValidateError")
        } catch let error as ValidateError {
            XCTAssertEqual(error.emailErrorMessage, L10n.Auth.validationEmailEmpty)
            XCTAssertTrue(error.passwordErrorMessage.isEmpty)
            XCTAssertFalse(repo.signInCalled)
        } catch {
            XCTFail("Unexpected error type: \(error)")
        }
    }
    
    func testSignIn_WithInvalidEmailFormat_ShouldThrowEmailInvalidError() async {
        // Given
        let repo = MockAuthRepo()
        let useCase = SignInUseCase(Authrepo: repo)
        let invalidEmails = ["invalidemail", "test@", "test@domain", "test@.com", "test@domain.", "test@domain.c", "www@www.com", "user@www.gmail.com"]
        
        for email in invalidEmails {
            do {
                try await useCase.execute(email: email, password: "password123")
                XCTFail("Should throw ValidateError for email: \(email)")
            } catch let error as ValidateError {
                XCTAssertEqual(error.emailErrorMessage, L10n.Auth.validationEmailInvalid, "Failed for email: \(email)")
                XCTAssertTrue(error.passwordErrorMessage.isEmpty)
                XCTAssertFalse(repo.signInCalled)
            } catch {
                XCTFail("Unexpected error type: \(error) for email: \(email)")
            }
        }
    }
    
    func testSignIn_WithEmptyPassword_ShouldThrowPasswordEmptyError() async {
        // Given
        let repo = MockAuthRepo()
        let useCase = SignInUseCase(Authrepo: repo)
        
        // When/Then
        do {
            try await useCase.execute(email: "test@domain.com", password: "")
            XCTFail("Should throw ValidateError")
        } catch let error as ValidateError {
            XCTAssertTrue(error.emailErrorMessage.isEmpty)
            XCTAssertEqual(error.passwordErrorMessage, L10n.Auth.validationPasswordEmpty)
            XCTAssertFalse(repo.signInCalled)
        } catch {
            XCTFail("Unexpected error type: \(error)")
        }
    }
    
    func testSignIn_WithShortPassword_ShouldThrowPasswordMinLengthError() async {
        // Given
        let repo = MockAuthRepo()
        let useCase = SignInUseCase(Authrepo: repo)
        
        // When/Then
        do {
            try await useCase.execute(email: "test@domain.com", password: "12345")
            XCTFail("Should throw ValidateError")
        } catch let error as ValidateError {
            XCTAssertTrue(error.emailErrorMessage.isEmpty)
            XCTAssertEqual(error.passwordErrorMessage, L10n.Auth.validationPasswordMinLength)
            XCTAssertFalse(repo.signInCalled)
        } catch {
            XCTFail("Unexpected error type: \(error)")
        }
    }
    
    func testSignIn_WithValidInputs_ShouldCallRepo() async {
        // Given
        let repo = MockAuthRepo()
        let useCase = SignInUseCase(Authrepo: repo)
        
        // When/Then
        do {
            try await useCase.execute(email: "test@domain.com", password: "password123")
            XCTAssertTrue(repo.signInCalled)
            XCTAssertEqual(repo.signInEmail, "test@domain.com")
            XCTAssertEqual(repo.signInPassword, "password123")
        } catch {
            XCTFail("Should not throw any error: \(error)")
        }
    }
    
    // MARK: - RegisterUseCase Tests
    
    func testRegister_WithEmptyName_ShouldThrowNameEmptyError() async {
        // Given
        let repo = MockAuthRepo()
        let useCase = RegisterUseCase(authRepo: repo)
        
        // When/Then
        do {
            try await useCase.execute(fullName: "   ", email: "test@domain.com", password: "password123", confirmPassword: "password123")
            XCTFail("Should throw RegisterValidateError")
        } catch let error as RegisterValidateError {
            XCTAssertEqual(error.fullNameErrorMessage, L10n.Auth.validationNameEmpty)
            XCTAssertTrue(error.emailErrorMessage.isEmpty)
            XCTAssertTrue(error.passwordErrorMessage.isEmpty)
            XCTAssertTrue(error.confirmPasswordErrorMessage.isEmpty)
            XCTAssertFalse(repo.createUserCalled)
        } catch {
            XCTFail("Unexpected error type: \(error)")
        }
    }
    
    func testRegister_WithInvalidEmail_ShouldThrowEmailInvalidError() async {
        // Given
        let repo = MockAuthRepo()
        let useCase = RegisterUseCase(authRepo: repo)
        
        // When/Then
        do {
            try await useCase.execute(fullName: "John Doe", email: "www@www.com", password: "password123", confirmPassword: "password123")
            XCTFail("Should throw RegisterValidateError")
        } catch let error as RegisterValidateError {
            XCTAssertTrue(error.fullNameErrorMessage.isEmpty)
            XCTAssertEqual(error.emailErrorMessage, L10n.Auth.validationEmailInvalid)
            XCTAssertTrue(error.passwordErrorMessage.isEmpty)
            XCTAssertTrue(error.confirmPasswordErrorMessage.isEmpty)
            XCTAssertFalse(repo.createUserCalled)
        } catch {
            XCTFail("Unexpected error type: \(error)")
        }
    }
    
    func testRegister_WithShortPassword_ShouldThrowPasswordMinLengthError() async {
        // Given
        let repo = MockAuthRepo()
        let useCase = RegisterUseCase(authRepo: repo)
        
        // When/Then
        do {
            try await useCase.execute(fullName: "John Doe", email: "test@domain.com", password: "123", confirmPassword: "123")
            XCTFail("Should throw RegisterValidateError")
        } catch let error as RegisterValidateError {
            XCTAssertTrue(error.fullNameErrorMessage.isEmpty)
            XCTAssertTrue(error.emailErrorMessage.isEmpty)
            XCTAssertEqual(error.passwordErrorMessage, L10n.Auth.validationPasswordMinLength)
            XCTAssertTrue(error.confirmPasswordErrorMessage.isEmpty)
            XCTAssertFalse(repo.createUserCalled)
        } catch {
            XCTFail("Unexpected error type: \(error)")
        }
    }
    
    func testRegister_WithMismatchedConfirmPassword_ShouldThrowPasswordsMismatchError() async {
        // Given
        let repo = MockAuthRepo()
        let useCase = RegisterUseCase(authRepo: repo)
        
        // When/Then
        do {
            try await useCase.execute(fullName: "John Doe", email: "test@domain.com", password: "password123", confirmPassword: "differentpassword")
            XCTFail("Should throw RegisterValidateError")
        } catch let error as RegisterValidateError {
            XCTAssertTrue(error.fullNameErrorMessage.isEmpty)
            XCTAssertTrue(error.emailErrorMessage.isEmpty)
            XCTAssertTrue(error.passwordErrorMessage.isEmpty)
            XCTAssertEqual(error.confirmPasswordErrorMessage, L10n.Auth.validationPasswordsMismatch)
            XCTAssertFalse(repo.createUserCalled)
        } catch {
            XCTFail("Unexpected error type: \(error)")
        }
    }
    
    func testRegister_WithValidInputs_ShouldCallRepoAndSplitName() async {
        // Given
        let repo = MockAuthRepo()
        let useCase = RegisterUseCase(authRepo: repo)
        
        // When/Then
        do {
            try await useCase.execute(fullName: "John Doe Smith", email: "test@domain.com", password: "password123", confirmPassword: "password123")
            XCTAssertTrue(repo.createUserCalled)
            XCTAssertEqual(repo.createUserEmail, "test@domain.com")
            XCTAssertEqual(repo.createUserPassword, "password123")
            XCTAssertEqual(repo.createUserFirstName, "John")
            XCTAssertEqual(repo.createUserLastName, "Doe Smith")
        } catch {
            XCTFail("Should not throw any error: \(error)")
        }
    }
}
