import Foundation

struct CheckoutApplePayConfiguration {
    let merchantIdentifier: String
    let merchantDisplayName: String
    let countryCode: String

    static func live(bundle: Bundle = .main) throws -> CheckoutApplePayConfiguration {
        let merchantIdentifier = try value(for: "APPLE_PAY_MERCHANT_IDENTIFIER", in: bundle)
        let countryCode = valueIfPresent(for: "APPLE_PAY_COUNTRY_CODE", in: bundle) ?? "US"
        let merchantDisplayName = bundle.object(forInfoDictionaryKey: "CFBundleName") as? String ?? "Marktek"

        return CheckoutApplePayConfiguration(
            merchantIdentifier: merchantIdentifier,
            merchantDisplayName: merchantDisplayName,
            countryCode: countryCode
        )
    }

    private static func value(for key: String, in bundle: Bundle) throws -> String {
        guard let value = valueIfPresent(for: key, in: bundle) else {
            throw CheckoutPaymentAuthorizationError.missingMerchantIdentifier
        }

        return value
    }

    private static func valueIfPresent(for key: String, in bundle: Bundle) -> String? {
        guard let value = bundle.object(forInfoDictionaryKey: key) as? String,
              !value.isEmpty,
              !value.contains("$(") else {
            return nil
        }

        return value
    }
}
