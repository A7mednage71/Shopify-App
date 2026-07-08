import Foundation
import Common

struct OnboardingItem: Identifiable, Equatable {
    let id: String
    let imageName: String
    let title: String
    let description: String

    init(imageName: String, title: String, description: String) {
        self.id = imageName
        self.imageName = imageName
        self.title = title
        self.description = description
    }
}

extension OnboardingItem {
    static let defaults: [OnboardingItem] = [
        OnboardingItem(
            imageName: "onboarding_discover",
            title: L10n.Onboarding.discoverTitle,
            description: L10n.Onboarding.discoverDesc
        ),
        OnboardingItem(
            imageName: "onboarding_favorites",
            title: L10n.Onboarding.favoritesTitle,
            description: L10n.Onboarding.favoritesDesc
        ),
        OnboardingItem(
            imageName: "onboarding_checkout",
            title: L10n.Onboarding.checkoutTitle,
            description: L10n.Onboarding.checkoutDesc
        ),
    ]
}
