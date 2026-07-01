extension CollectionDataModel {
    func toDomain() -> Collection {
        Collection(
            id: id,
            title: title,
            handle: handle,
            imageURL: imageURL
        )
    }
}
