import Foundation

public protocol ShoppingAssistantRepository: Sendable {
    func getReply(messages: [ChatMessage], catalog: [ShopProduct], brands: [Collection], categories: [Collection]) async throws -> AssistantReply
}
