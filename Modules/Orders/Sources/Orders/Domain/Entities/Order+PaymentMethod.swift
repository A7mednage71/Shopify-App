//
//  File.swift
//  
//
//  Created by Esraa Ehab on 07/07/2026.
//

import Foundation

extension Order {
    public enum PaymentMethod {
        case applePay
        case cashOnDelivery
        case unknown

        public var title: String {
            switch self {
            case .applePay: return "Apple Pay"
            case .cashOnDelivery: return "Cash on Delivery"
            case .unknown: return "Credit Card"
            }
        }

        public var systemImageName: String {
            switch self {
            case .applePay: return "applelogo"
            case .cashOnDelivery: return "banknote.fill"
            case .unknown: return "creditcard.fill"
            }
        }
    }

    public var paymentMethod: PaymentMethod {
        switch financialStatus?.uppercased() {
        case "PAID":
            return .applePay
        case "PENDING":
            return .cashOnDelivery
        default:
            return .unknown
        }
    }
}
