import Foundation

extension String {
    var checkoutOrderStatusTitle: String {
        split(separator: "_")
            .map { part in
                part.prefix(1).uppercased() + part.dropFirst().lowercased()
            }
            .joined(separator: " ")
    }
}
