import Foundation

public protocol ShoppingAssistantRepository: Sendable {
    func getReply(messages: [ChatMessage], catalog: [ShopProduct]) async throws -> AssistantReply
}
