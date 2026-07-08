//
//  File.swift
//  Orders
//
//  Created by Ahmed Nageh on 07/07/2026.
//

import Foundation
import SwiftUI

enum OrderStatus {
    case pending
    case inProgress
    case delivered

    var text: String {
        switch self {
        case .pending: return "Pending"
        case .inProgress: return "In Progress"
        case .delivered: return "Delivered"
        }
    }

    var color: Color {
        switch self {
        case .pending: return Color(red: 254/255, green: 195/255, blue: 57/255)
        case .inProgress: return Color(red: 254/255, green: 109/255, blue: 74/255)
        case .delivered: return Color(red: 39/255, green: 174/255, blue: 96/255)
        }
    }

    var iconName: String {
        switch self {
        case .pending: return "doc.plaintext"
        case .inProgress: return "bicycle"
        case .delivered: return "checkmark"
        }
    }
}
