import Foundation

public protocol ShoppingAssistantRemoteDataSource: Sendable {
    func getReply(messages: [ChatMessage], catalog: [ShopProduct]) async throws -> AssistantReply
}
