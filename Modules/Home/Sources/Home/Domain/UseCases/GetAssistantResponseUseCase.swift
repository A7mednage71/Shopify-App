import Foundation

public protocol GetAssistantResponseUseCaseProtocol: Sendable {
    func execute(messages: [ChatMessage], catalog: [ShopProduct]) async throws -> AssistantReply
}

public struct GetAssistantResponseUseCase: GetAssistantResponseUseCaseProtocol, Sendable {
    private let repository: any ShoppingAssistantRepository

    public init(repository: any ShoppingAssistantRepository) {
        self.repository = repository
    }

    public func execute(messages: [ChatMessage], catalog: [ShopProduct]) async throws -> AssistantReply {
        try await repository.getReply(messages: messages, catalog: catalog)
    }
}
