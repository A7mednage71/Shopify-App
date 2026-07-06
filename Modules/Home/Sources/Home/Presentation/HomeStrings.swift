import Foundation

// MARK: - Home Strings
// Central repository for all user-visible strings in the Home feature.
// Replace values here to support future localization (e.g. NSLocalizedString).

public enum HomeStrings {

    // MARK: - Search Bar
    enum Search {
        static let placeholder = "Search any Product..."
    }

    // MARK: - Category Section
    enum Category {
        static let sectionTitle = "Categories"
        static let brandsTitle  = "Brands"
        static let sortButton   = "Sort"
        static let filterButton = "Filter"
    }

    // MARK: - Deal of the Day
    enum Deal {
        static let sectionTitle = "Deal of the Day"
        static let viewAll      = "View all"
        static let remaining    = "remaining"
    }

    // MARK: - Special Offers
    enum SpecialOffers {
        static let title    = "Special Offers"
        static let subtitle = "We make sure you get the offer you need at best prices"
    }

    // MARK: - Flat & Heels Banner
    enum FlatHeels {
        static let title    = "Flat and Heels"
        static let subtitle = "Stand a chance to get rewarded"
        static let cta      = "Visit now"
    }

    // MARK: - Trending Products
    enum Trending {
        static let sectionTitle = "Trending Products"
        static let lastDate     = "Last Date 29/02/22"
        static let viewAll      = "View all"
    }

    // MARK: - Product Card
    enum ProductCard {
        static func discountLabel(_ percent: Int) -> String { "\(percent)% off" }
    }
}
