import Foundation

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
            title: "Find Your Next Favorite",
            description: "Browse fresh products, compare details, and discover picks that fit your style."
        ),
        OnboardingItem(
            imageName: "onboarding_favorites",
            title: "Save What You Love",
            description: "Keep favorites close so your best finds are ready when you come back."
        ),
        OnboardingItem(
            imageName: "onboarding_checkout",
            title: "Shop With Confidence",
            description: "Review product details, choose options, and move smoothly toward checkout."
        ),
    ]
}
