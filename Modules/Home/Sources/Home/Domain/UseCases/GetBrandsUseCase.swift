protocol GetBrandsUseCaseProtocol: Sendable {
    func execute(first: Int) async throws -> [Collection]
}

struct GetBrandsUseCase: GetBrandsUseCaseProtocol, Sendable {
    private let repository: any HomeRepository

    init(repository: any HomeRepository) {
        self.repository = repository
    }

    func execute(first: Int = 20) async throws -> [Collection] {
        try await repository.getBrands(first: first)
    }
}
