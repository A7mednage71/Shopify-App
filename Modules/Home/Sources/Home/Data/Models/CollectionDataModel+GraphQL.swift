@preconcurrency import MarktekNetworking

extension CollectionDataModel {
    init(customNode node: GetCustomCollectionsQuery.Data.Collections.Node) {
        self.id = node.id
        self.title = node.title
        self.handle = node.handle
        self.imageURL = node.image.map { String($0.url) }
    }

    init(smartNode node: GetSmartCollectionsQuery.Data.Collections.Node) {
        self.id = node.id
        self.title = node.title
        self.handle = node.handle
        self.imageURL = node.image.map { String($0.url) }
    }
}

