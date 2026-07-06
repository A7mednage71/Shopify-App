//
//  File.swift
//  
//
//  Created by Esraa Ehab on 05/07/2026.
//

import Foundation

public struct FavoriteProduct: Identifiable, Equatable {
    public let id: String
    public let title: String
    public let imageURL: String
    public let price: Double
    public let currencyCode: String
    public let compareAtPrice: Double?
    
    public init(id: String, title: String, imageURL: String, price: Double, currencyCode: String, compareAtPrice: Double?) {
        self.id = id
        self.title = title
        self.imageURL = imageURL
        self.price = price
        self.currencyCode = currencyCode
        self.compareAtPrice = compareAtPrice
    }
}
