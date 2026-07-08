//
//  File.swift
//  
//
//  Created by Esraa Ehab on 06/07/2026.
//

import Foundation

public struct Order: Identifiable, Sendable, Equatable {
    public let id: String
    public let name: String
    public let orderNumber: Int
    public let processedAt: Date
    public let financialStatus: String?
    public let fulfillmentStatus: String
    public let totalPrice: String
    public let currencyCode: String
    public let shippingAddress: String?
    public let customerName: String
    public let lineItems: [OrderLineItem]

    public init(
        id: String,
        name: String,
        orderNumber: Int,
        processedAt: Date,
        financialStatus: String?,
        fulfillmentStatus: String,
        totalPrice: String,
        currencyCode: String,
        shippingAddress: String?,
        customerName: String,
        lineItems: [OrderLineItem]
    ) {
        self.id = id
        self.name = name
        self.orderNumber = orderNumber
        self.processedAt = processedAt
        self.financialStatus = financialStatus
        self.fulfillmentStatus = fulfillmentStatus
        self.totalPrice = totalPrice
        self.currencyCode = currencyCode
        self.shippingAddress = shippingAddress
        self.customerName = customerName
        self.lineItems = lineItems
    }
}

public struct OrderLineItem: Identifiable, Sendable, Equatable {
    public let id: String
    public let title: String
    public let quantity: Int
    public let price: String
    public let currencyCode: String
    public let imageURL: String?
    public let productID: String?

    public init(
        id: String,
        title: String,
        quantity: Int,
        price: String,
        currencyCode: String,
        imageURL: String?,
        productID: String?
    ) {
        self.id = id
        self.title = title
        self.quantity = quantity
        self.price = price
        self.currencyCode = currencyCode
        self.imageURL = imageURL
        self.productID = productID
    }
}
