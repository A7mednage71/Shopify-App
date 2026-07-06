import Foundation

public protocol ShoppingAssistantRemoteDataSource: Sendable {
    func getReply(messages: [ChatMessage], catalog: [ShopProduct], brands: [Collection], categories: [Collection]) async throws -> AssistantReply
}
