//
//  File.swift
//  
//
//  Created by Esraa Ehab on 07/07/2026.
//

import Foundation

extension OrderDataModel {
    public func toDomain() -> Order {
        Order(
            id: id,
            name: name,
            orderNumber: orderNumber,
            processedAt: processedAt,
            financialStatus: financialStatus,
            fulfillmentStatus: fulfillmentStatus,
            totalPrice: totalPriceAmount,
            currencyCode: currencyCode,
            lineItems: lineItems.map { $0.toDomain() }
        )
    }
}

extension OrderLineItemDataModel {
    public func toDomain() -> OrderLineItem {
        OrderLineItem(
            id: id,
            title: title,
            quantity: quantity,
            price: priceAmount,
            currencyCode: currencyCode,
            imageURL: imageURL
        )
    }
}
