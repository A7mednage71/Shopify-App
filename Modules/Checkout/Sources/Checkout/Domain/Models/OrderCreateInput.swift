import Foundation

public struct OrderCreateInput: Sendable {
    public let currency: String
    public let email: String?
    public let phone: String?
    public let customerId: String?             
    public let lineItems: [LineItemInput]
    public let shippingAddress: ShippingAddressInput?
    public let shippingLine: ShippingLineInput?
    public let discountAmount: Decimal?         
    public let discountCode: String?
    public let financialStatus: OrderFinancialStatus
    public let totalAmount: Decimal         

    public init(
        currency: String,
        email: String?,
        phone: String?,
        customerId: String?,
        lineItems: [LineItemInput],
        shippingAddress: ShippingAddressInput?,
        shippingLine: ShippingLineInput?,
        discountAmount: Decimal?,
        discountCode: String?,
        financialStatus: OrderFinancialStatus,
        totalAmount: Decimal
    ) {
        self.currency = currency
        self.email = email
        self.phone = phone
        self.customerId = customerId
        self.lineItems = lineItems
        self.shippingAddress = shippingAddress
        self.shippingLine = shippingLine
        self.discountAmount = discountAmount
        self.discountCode = discountCode
        self.financialStatus = financialStatus
        self.totalAmount = totalAmount
    }
}

public enum OrderFinancialStatus: String, Sendable {
    case paid = "PAID"
    case pending = "PENDING"
}

public struct ShippingAddressInput: Sendable {
    public let firstName: String?
    public let lastName: String
    public let company: String?
    public let address1: String
    public let address2: String?
    public let city: String
    public let provinceCode: String?
    public let countryCode: String
    public let zip: String
    public let phone: String?

    public init(
        firstName: String?,
        lastName: String,
        company: String?,
        address1: String,
        address2: String?,
        city: String,
        provinceCode: String?,
        countryCode: String,
        zip: String,
        phone: String?
    ) {
        self.firstName = firstName
        self.lastName = lastName
        self.company = company
        self.address1 = address1
        self.address2 = address2
        self.city = city
        self.provinceCode = provinceCode
        self.countryCode = countryCode
        self.zip = zip
        self.phone = phone
    }
}

public struct ShippingLineInput: Sendable {
    public let title: String
    public let code: String
    public let amount: Decimal
    public let currencyCode: String

    public init(title: String, code: String, amount: Decimal, currencyCode: String) {
        self.title = title
        self.code = code
        self.amount = amount
        self.currencyCode = currencyCode
    }
}

public struct LineItemInput: Equatable, Sendable {
    public let variantId: String
    public let quantity: Int

    public init(variantId: String, quantity: Int) {
        self.variantId = variantId
        self.quantity = quantity
    }
}
