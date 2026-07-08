//
//  File.swift
//  
//
//  Created by Esraa Ehab on 07/07/2026.
//

import Foundation
import Common

extension Order {
    public enum PaymentMethod {
        case applePay
        case cashOnDelivery
        case unknown

        public var title: String {
            switch self {
            case .applePay: return L10n.Orders.paymentApplePay
            case .cashOnDelivery: return L10n.Orders.paymentCashOnDelivery
            case .unknown: return L10n.Orders.paymentCreditCard
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
