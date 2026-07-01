public struct Collection: Identifiable, Sendable {
    public let id: String
    public let title: String
    public let handle: String
    public let imageURL: String?

    public init(id: String, title: String, handle: String, imageURL: String?) {
        self.id = id
        self.title = title
        self.handle = handle
        self.imageURL = imageURL
    }
}
