import Foundation

public enum CheckoutPaymentMethodType: String, CaseIterable, Identifiable, Sendable {
    case card
    case applePay
    case cashOnDelivery

    public var id: String { rawValue }
}

public struct CheckoutPaymentMethod: Identifiable, Equatable, Sendable {
    public let type: CheckoutPaymentMethodType
    public let title: String
    public let subtitle: String
    public let systemImageName: String

    public init(
        type: CheckoutPaymentMethodType,
        title: String,
        subtitle: String,
        systemImageName: String
    ) {
        self.type = type
        self.title = title
        self.subtitle = subtitle
        self.systemImageName = systemImageName
    }

    public var id: CheckoutPaymentMethodType { type }
}
