import Foundation
import Common

// MARK: - Home Strings
// Central repository for all user-visible strings in the Home feature.
// Replace values here to support future localization (e.g. NSLocalizedString).

public enum HomeStrings {

    // MARK: - Search Bar
    enum Search {
        static var placeholder: String { L10n.HomeStrs.placeholder }
    }

    // MARK: - Category Section
    enum Category {
        static var sectionTitle: String { L10n.HomeStrs.categoriesSectionTitle }
        static var brandsTitle: String { L10n.HomeStrs.brandsTitle }
        static var sortButton: String { L10n.HomeStrs.sortButton }
        static var filterButton: String { L10n.HomeStrs.filterButton }
    }

    // MARK: - Deal of the Day
    enum Deal {
        static var sectionTitle: String { L10n.HomeStrs.dealSectionTitle }
        static var viewAll: String { L10n.HomeStrs.viewAll }
        static var remaining: String { L10n.HomeStrs.remaining }
    }

    // MARK: - Special Offers
    enum SpecialOffers {
        static var title: String { L10n.HomeStrs.offersTitle }
        static var subtitle: String { L10n.HomeStrs.offersSubtitle }
    }

    // MARK: - Flat & Heels Banner
    enum FlatHeels {
        static var title: String { L10n.HomeStrs.offersTitle }
        static var subtitle: String { L10n.HomeStrs.offersSubtitle }
        static var cta: String { L10n.HomeStrs.cta }
    }

    // MARK: - Trending Products
    enum Trending {
        static var sectionTitle: String { L10n.HomeStrs.trendingSectionTitle }
        static var lastDate: String { L10n.HomeStrs.lastDate }
        static var viewAll: String { L10n.HomeStrs.viewAll }
    }

    // MARK: - Product Card
    enum ProductCard {
        static func discountLabel(_ percent: Int) -> String { "\(percent)% off" }
    }
}
