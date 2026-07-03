@preconcurrency import MarktekNetworking

extension CollectionDataModel {
    init(node: GetCollectionsQuery.Data.Collections.Node) {
        self.id = node.id
        self.title = node.title
        self.handle = node.handle
        self.imageURL = node.image.map { String($0.url) }
    }
}
