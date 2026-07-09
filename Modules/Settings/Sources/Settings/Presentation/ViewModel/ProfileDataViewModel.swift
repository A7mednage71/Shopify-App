import Combine
import Foundation

public enum CustomerProfileState: Equatable {
    case idle
    case loading
    case success(CustomerProfile)
    case failure(String)
}

@MainActor
public final class ProfileDataViewModel: ObservableObject {
    @Published public private(set) var state: CustomerProfileState = .idle
    @Published public private(set) var isSaving = false
    @Published public var saveErrorMessage: String?

    private let getCustomerProfileUseCase: any GetCustomerProfileUseCaseProtocol
    private let updateCustomerProfileUseCase: any UpdateCustomerProfileUseCaseProtocol

    init(
        getCustomerProfileUseCase: any GetCustomerProfileUseCaseProtocol,
        updateCustomerProfileUseCase: any UpdateCustomerProfileUseCaseProtocol
    ) {
        self.getCustomerProfileUseCase = getCustomerProfileUseCase
        self.updateCustomerProfileUseCase = updateCustomerProfileUseCase
    }

    public func loadProfileIfNeeded() async {
        //guard case .idle = state else { return }
        await loadProfile()
    }

    public func loadProfile() async {
        state = .loading

        do {
            state = .success(try await getCustomerProfileUseCase.execute())
        } catch {
            state = .failure(profileMessage(for: error))
        }
    }

    public func updateProfile(_ input: CustomerProfileUpdateInput) async {
        guard !isSaving else { return }

        isSaving = true
        saveErrorMessage = nil

        do {
            state = .success(try await updateCustomerProfileUseCase.execute(input))
        } catch {
            saveErrorMessage = profileMessage(for: error)
        }

        isSaving = false
    }

    public func reset() {
        state = .idle
        isSaving = false
        saveErrorMessage = nil
    }

    private func profileMessage(for error: Error) -> String {
        if let localizedError = error as? LocalizedError,
           let description = localizedError.errorDescription,
           !description.isEmpty {
            return description
        }

        return error.localizedDescription
    }
}
