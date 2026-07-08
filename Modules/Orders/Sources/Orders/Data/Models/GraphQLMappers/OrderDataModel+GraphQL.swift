//
//  File.swift
//
//
//  Created by Esraa Ehab on 07/07/2026.
//

import Foundation
import MarktekNetworking

extension OrderDataModel {
    public init(gqlOrderNode: GetCustomerOrdersQuery.Data.Customer.Orders.Edge.Node, customerName: String) {
        self.id = gqlOrderNode.id
        self.name = gqlOrderNode.name
        self.orderNumber = gqlOrderNode.orderNumber
        self.processedAt = ISO8601DateFormatter().date(from: gqlOrderNode.processedAt) ?? Date()
        self.financialStatus = gqlOrderNode.financialStatus?.rawValue
        self.fulfillmentStatus = gqlOrderNode.fulfillmentStatus.rawValue
        self.totalPriceAmount = "\(gqlOrderNode.currentTotalPrice.amount)"
        self.currencyCode = gqlOrderNode.currentTotalPrice.currencyCode.rawValue
        self.customerName = customerName
        
        self.lineItems = gqlOrderNode.lineItems.edges.enumerated().map { index, edge in
            let node = edge.node
            return OrderLineItemDataModel(
                id: "\(gqlOrderNode.id)-line-\(index)",
                title: node.title,
                quantity: node.quantity,
                priceAmount: "\(node.originalTotalPrice.amount)",
                currencyCode: node.originalTotalPrice.currencyCode.rawValue,
                imageURL: node.variant?.image?.url,
                productID: node.variant?.product.id
            )
        }
        if let address = gqlOrderNode.shippingAddress {
            let cityLine = [address.city, address.province, address.zip]
                .compactMap { $0?.trimmedNonEmpty }
                .joined(separator: ", ")

            self.shippingAddress = [
                address.address1,
                address.address2,
                cityLine,
                address.country,
                address.phone
            ]
            .compactMap { $0?.trimmedNonEmpty }
            .joined(separator: "\n")
        } else {
            self.shippingAddress = nil
        }
    }
}

private extension String {
    var trimmedNonEmpty: String? {
        let value = trimmingCharacters(in: .whitespacesAndNewlines)
        return value.isEmpty ? nil : value
    }
}
