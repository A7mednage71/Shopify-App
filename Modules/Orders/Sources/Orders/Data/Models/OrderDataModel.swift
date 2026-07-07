//
//  File.swift
//  
//
//  Created by Esraa Ehab on 07/07/2026.
//

import Foundation

public struct OrderDataModel: Sendable {
    public let id: String
    public let name: String
    public let orderNumber: Int
    public let processedAt: Date
    public let financialStatus: String?
    public let fulfillmentStatus: String
    public let totalPriceAmount: String
    public let currencyCode: String
    public let lineItems: [OrderLineItemDataModel]

    public init(
        id: String,
        name: String,
        orderNumber: Int,
        processedAt: Date,
        financialStatus: String?,
        fulfillmentStatus: String,
        totalPriceAmount: String,
        currencyCode: String,
        lineItems: [OrderLineItemDataModel]
    ) {
        self.id = id
        self.name = name
        self.orderNumber = orderNumber
        self.processedAt = processedAt
        self.financialStatus = financialStatus
        self.fulfillmentStatus = fulfillmentStatus
        self.totalPriceAmount = totalPriceAmount
        self.currencyCode = currencyCode
        self.lineItems = lineItems
    }
}

public struct OrderLineItemDataModel: Sendable {
    public let id: String
    public let title: String
    public let quantity: Int
    public let priceAmount: String
    public let currencyCode: String
    public let imageURL: String?

    public init(
        id: String,
        title: String,
        quantity: Int,
        priceAmount: String,
        currencyCode: String,
        imageURL: String?
    ) {
        self.id = id
        self.title = title
        self.quantity = quantity
        self.priceAmount = priceAmount
        self.currencyCode = currencyCode
        self.imageURL = imageURL
    }
}
