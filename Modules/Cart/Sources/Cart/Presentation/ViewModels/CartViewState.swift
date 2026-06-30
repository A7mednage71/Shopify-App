//
//  CartViewState.swift
//  Cart
//
//  Created by Eslam Elnady on 30/06/2026.
//


public enum CartViewState: Equatable {
    case idle
    case loading
    case success(CartDetails)
    case failure(String)
}