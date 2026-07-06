import Foundation

extension ProductDetails {
    var totalAvailableQuantity: Int? {
        let quantities = variants.compactMap(\.quantityAvailable)
        guard !quantities.isEmpty else { return nil }
        return quantities.reduce(0, +)
    }

    var inferredMaterial: String {
        if let optionValue = options
            .first(where: { $0.name.localizedCaseInsensitiveContains("material") || $0.name.localizedCaseInsensitiveContains("fabric") })?
            .values
            .first?
            .trimmedNonEmpty {
            return optionValue
        }

        let materialKeywords = [
            "cotton",
            "leather",
            "polyester",
            "wool",
            "denim",
            "canvas",
            "rubber",
            "mesh",
            "nylon",
            "fleece"
        ]

        if let tag = tags.first(where: { tag in
            materialKeywords.contains { keyword in
                tag.localizedCaseInsensitiveContains(keyword)
            }
        })?.trimmedNonEmpty {
            return tag
        }

        return "Not specified"
    }
}

private extension String {
    var trimmedNonEmpty: String? {
        let trimmed = trimmingCharacters(in: .whitespacesAndNewlines)
        return trimmed.isEmpty ? nil : trimmed
    }
}
