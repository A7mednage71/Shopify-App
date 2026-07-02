@preconcurrency import MarktekNetworking

extension SearchResponseData {
    init(data: SearchProductsQuery.Data) {
        self.data = SearchData(data: data)
    }
}

extension SearchData {
    init(data: SearchProductsQuery.Data) {
        self.search = SearchConnection(search: data.search)
    }
}

extension SearchConnection {
    init(search: SearchProductsQuery.Data.Search) {
        self.totalCount = search.totalCount
        self.edges = search.edges.compactMap { SearchEdge(edge: $0) }
        self.pageInfo = PageInfo(pageInfo: search.pageInfo)
    }
}

extension PageInfo {
    init(pageInfo: SearchProductsQuery.Data.Search.PageInfo) {
        self.hasNextPage = pageInfo.hasNextPage
        self.endCursor = pageInfo.endCursor
    }
}

extension SearchEdge {
    init?(edge: SearchProductsQuery.Data.Search.Edge) {
        guard let productNode = SearchProductNode(node: edge.node) else { return nil }
        self.cursor = edge.cursor
        self.node = productNode
    }
}

extension SearchProductNode {
    init?(node: SearchProductsQuery.Data.Search.Edge.Node) {
        guard let product = node.asProduct else { return nil }
        self.id = String(product.id)
        self.title = product.title
        self.description = product.description
        self.handle = product.handle
        self.vendor = product.vendor
        self.productType = product.productType
        self.tags = product.tags
        self.availableForSale = product.availableForSale
        
        self.options = product.options.map { option in
            ProductOptionDataModel(name: option.name, values: option.values)
        }
        
        self.priceRange = PriceRange(
            minVariantPrice: Money(
                amount: String(product.priceRange.minVariantPrice.amount),
                currencyCode: product.priceRange.minVariantPrice.currencyCode.rawValue
            ),
            maxVariantPrice: Money(
                amount: String(product.priceRange.maxVariantPrice.amount),
                currencyCode: product.priceRange.maxVariantPrice.currencyCode.rawValue
            )
        )
        
        let imageEdges = product.images.edges.map { imgEdge in
            ImageEdge(
                node: ImageNode(
                    url: String(imgEdge.node.url),
                    altText: imgEdge.node.altText
                )
            )
        }
        self.images = ImageConnection(edges: imageEdges)
        
        let variantEdges = product.variants.edges.map { varEdge in
            VariantEdge(
                node: ProductVariantDataModel(
                    id: String(varEdge.node.id),
                    title: varEdge.node.title,
                    availableForSale: varEdge.node.availableForSale,
                    price: Money(
                        amount: String(varEdge.node.price.amount),
                        currencyCode: varEdge.node.price.currencyCode.rawValue
                    )
                )
            )
        }
        self.variants = VariantConnection(edges: variantEdges)
    }
}
