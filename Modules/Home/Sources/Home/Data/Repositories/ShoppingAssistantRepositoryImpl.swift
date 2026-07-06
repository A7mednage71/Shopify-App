import Foundation

public struct ShoppingAssistantRepositoryImpl: ShoppingAssistantRepository {
    private let remoteDataSource: any ShoppingAssistantRemoteDataSource

    public init(remoteDataSource: any ShoppingAssistantRemoteDataSource) {
        self.remoteDataSource = remoteDataSource
    }

    public func getReply(messages: [ChatMessage], catalog: [ShopProduct]) async throws -> AssistantReply {
        try await remoteDataSource.getReply(messages: messages, catalog: catalog)
    }
}
