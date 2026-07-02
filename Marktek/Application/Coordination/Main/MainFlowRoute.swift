enum MainFlowRoute: Hashable {
    case home(HomeFlowRoute)
    case cart(CartFlowRoute)
    case favorites(FavoritesFlowRoute)
    case profile(ProfileFlowRoute)
}
