//
//  File.swift
//  
//
//  Created by Esraa Ehab on 07/07/2026.
//

import Foundation
import MarktekNetworking

extension OrderDataModel {
    public init(gqlOrderNode: GetCustomerOrdersQuery.Data.Customer.Orders.Edge.Node) {
        self.id = gqlOrderNode.id
        self.name = gqlOrderNode.name
        self.orderNumber = gqlOrderNode.orderNumber
        self.processedAt = ISO8601DateFormatter().date(from: gqlOrderNode.processedAt) ?? Date()
        self.financialStatus = gqlOrderNode.financialStatus?.rawValue
        self.fulfillmentStatus = gqlOrderNode.fulfillmentStatus.rawValue
        self.totalPriceAmount = "\(gqlOrderNode.currentTotalPrice.amount)"
        self.currencyCode = gqlOrderNode.currentTotalPrice.currencyCode.rawValue

        self.lineItems = gqlOrderNode.lineItems.edges.enumerated().map { index, edge in
            let node = edge.node
            return OrderLineItemDataModel(
                id: "\(gqlOrderNode.id)-line-\(index)",
                title: node.title,
                quantity: node.quantity,
                priceAmount: "\(node.originalTotalPrice.amount)",
                currencyCode: node.originalTotalPrice.currencyCode.rawValue,
                imageURL: node.variant?.image?.url
            )
        }
    }
}
