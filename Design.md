# Marktek iOS Design

This document is the project-level design reference for humans and AI agents working on the Shopify iOS app. Use it together with `Agents.md`, `Layers/Agent.md`, and `Modules/ProductInfo/UI_MODULE_STRUCTURE.md`.

## Product Summary

Marktek is a SwiftUI shopping app backed by Shopify. The app lets users browse product collections, search and filter products, inspect product details, manage favorites, edit cart contents, choose checkout options, place orders, and use a shopping assistant for catalog-aware recommendations.

## Main Architecture

The app is a modular iOS codebase built from Swift Package Manager feature modules. The root Xcode app target lives in `Marktek/`, while reusable feature code lives under `Modules/`.

Primary patterns:

- SwiftUI for UI.
- `ObservableObject` view models on `@MainActor`.
- Clean architecture for substantial features: `DI`, `Data`, `Domain`, `Presentation`.
- Swinject for dependency registration and app-level composition.
- Apollo iOS generated GraphQL operation types for Shopify Storefront and Admin APIs.
- Core Data through the `Persistence` package for local favorites.
- Shared UI tokens, currency helpers, and cart domain types through `Common`.

Tiny modules do not need empty layers. New substantial features should follow the layered module shape from `Modules/ProductInfo/UI_MODULE_STRUCTURE.md`.

## App Shell

The executable app lives in `Marktek/`.

- `Marktek/Application/MarktekApp.swift`: app entry point, Firebase setup, color scheme selection, and startup currency loading.
- `Marktek/Application/AppDIContainer.swift`: root Swinject assembler for app-composed feature dependencies.
- `Marktek/Application/NetworkingAssembly.swift`: app-level networking registrations.
- `Marktek/Application/Coordination`: app, auth, main tab, and shared navigation coordinators.
- `Marktek/Core/Networking`: older app-target networking helpers.
- `Marktek/Resources`: app-level images and colors.

Navigation is coordinator-owned. Feature modules expose public factories that return SwiftUI views. App coordinators pass route callbacks into feature factories instead of letting feature modules mutate app navigation directly.

Current top-level flow:

```text
MarktekApp
-> AppFlowView
-> MainFlowView
-> TabView: Home, Cart, Favorites, Profile
-> NavigationStack destinations: ProductInfo, Checkout, OrderConfirmation
```

`AuthFlowView` exists but is currently empty. Treat authentication integration as work in progress unless the active task says otherwise.

## Module Inventory

### `Modules/Common`

Shared app utilities and cross-feature domain types.

- `AppTheme.swift`: shared colors, fonts, and view styling helpers.
- `AppCurrency.swift`, `CurrencyService.swift`, `PriceView.swift`: currency selection, exchange rates, and price display.
- `CartCommonDomain`: cart models and use case protocols shared by Cart, Checkout, and ProductInfo.
- `Views/CommonErrorView.swift`: reusable error UI.

Use `Common` for stable shared concepts. Do not move feature-specific UI, business rules, or API mapping into it just because two files can import it.

### `Modules/MarktekNetworking`

Apollo GraphQL client and generated Shopify operation/schema types.

- `GraphQL/Queries`: Shopify Storefront GraphQL operations.
- `GraphQL/Admin`: Shopify Admin GraphQL operations.
- `Sources/MarktekNetworking`: public clients, interceptors, secret lookup, and exported generated modules.
- `Sources/ShopifyAPI`: generated Storefront schema and operation code.
- `Sources/ShopifyAdminAPI`: generated Admin schema and operation code.
- `GRAPHQL_USAGE.md`, `GRAPHQL_CODEGEN.md`: instructions for adding operations and running code generation.

Do not edit generated files by hand. Add or update `.graphql` operations, then regenerate with Apollo.

### `Modules/Home`

Storefront discovery and AI shopping assistant.

- `Domain`: collection, product, assistant entities, repositories, and use cases for catalog loading, filtering entry points, search, brands, categories, vendors, trending products, special offers, and assistant responses.
- `Data`: Shopify remote data sources, GraphQL-to-data mappers, data-to-domain mappers, Gemini assistant request/response helpers, and repository implementations.
- `Presentation`: `HomeViewModel`, search/filter/sort/vendor extensions, `ShoppingAssistantViewModel`, and SwiftUI views for home, category, vendor, shared product cards, and assistant UI.
- `DI`: Home assemblies and `HomeViewFactory`.

Home depends on `MarktekNetworking`, `Common`, `Favorites`, Swinject, and SwiftUI-Shimmer.

### `Modules/Cart`

Shopping cart feature.

- `Domain`: cart operation inputs, cart errors, repository protocol, quantity validation, and use cases for creating carts, loading the current cart, adding/updating/removing lines, and applying discounts.
- `Data`: Shopify cart remote data source, local data source, cart id storage, GraphQL mappers, repository implementation, and stale-cart recovery.
- `Presentation`: `CartViewModel`, `CartViewState`, loaded/loading/empty/failure states, line rows, discount control, summary, image loading, and cart-specific formatting helpers.
- `DI`: data, domain, presentation assemblies, view model factory, and public `CartViewFactory`.

Cart owns cart mutation behavior and cart recovery. Other modules should use shared cart use case protocols from `Common` instead of reaching into cart data sources.

### `Modules/ProductInfo`

Product details screen.

- `Domain`: `ProductDetails`, product repository protocol, and `GetProductInfoUseCase`.
- `Data`: Shopify product info data source, data model, domain mapper, and repository implementation.
- `Presentation`: `ProductInfoViewModel`, `ProductInfoViewState`, product details views, variant/quantity/add-to-cart/favorite UI, and support helpers.
- `DI`: data, domain, presentation assemblies, view model factory, and public `ProductInfoViewFactory`.

ProductInfo can call cart and favorites use cases injected through DI. It should not know app tab navigation; it receives route callbacks such as `onCartTap`.

### `Modules/Favorites`

Local favorites feature backed by Core Data.

- `Domain`: `FavoriteProduct`, `FavoritesRepository`, and `ManageFavoritesUseCase`.
- `Data`: Core Data repository implementation using `PersistenceController`.
- `Presentation`: `FavoritesViewModel`, list view, and favorite product card.
- `DI`: data, domain, presentation assemblies, and public `FavoritesViewFactory`.

Favorites is used directly by the Favorites tab and indirectly by Home and ProductInfo.

### `Modules/Checkout`

Checkout, payment, order creation, and post-order review.

- `Domain`: checkout address, discount, payment method, pricing, shipping, customer details, order models, payment strategy, repository protocol, and use cases for pricing, order creation, customer details, and review submission.
- `Data`: remote data source, customer token source, GraphQL mappers, Admin order input mapping, and repository implementation.
- `Presentation`: `CheckoutViewModel`, address/cart/order state, Apple Pay authorization, checkout sections, loading/failure/processing/order confirmation views, and review sheet.
- `DI`: presentation assembly currently composes data, domain, payment, view model, and view factory.

Checkout depends on cart use cases from `Common` so it can load the current cart and reset the cart after successful order creation.

### `Modules/Settings`

Profile and settings UI.

- `Domain`: `SettingsModel`.
- `Presentation`: `SettingsViewModel`, settings screen, profile card, rows, and personal information form.
- `DI`: `SettingsAssembly` and `SettingsViewFactory`.

Settings is currently a slimmer UI module. Add data/domain layers only when settings starts persisting or fetching real data.

### `Modules/Onboarding`

Standalone SwiftUI onboarding package.

- `Presentation`: onboarding model, palette, page view, progress view, and primary button.
- `DI`: public `OnboardingViewFactory`.
- `Resources`: onboarding assets and colors.

This module is presentation-focused. Keep it lightweight unless onboarding gains data or business behavior.

### `Modules/Persistence`

Core Data package.

- `PersistenceController`: shared Core Data stack and preview stack.
- `CoreDataContextProvider`: protocol for obtaining main and background contexts.
- `Resources/Marktek.momd`: compiled Core Data model.

Only persistence infrastructure belongs here. Feature-specific storage logic belongs in that feature's Data layer.

### `Modules/Authentication`

Authentication package using Firebase Auth and Google Sign-In.

- `Data`: Firebase/API data sources, auth errors, and auth repository implementation.
- `Domain`: sign-in, register, and Google sign-in use cases.
- `Assets.xcassets`: auth provider images.

This module is not fully integrated with the active app flow yet. Keep authentication changes scoped and coordinate app navigation through `Marktek/Application/Coordination/Auth`.

### `Modules/Authentication/Home` and `Modules/Authentication/Onboarding`

Nested workshop packages that appear to duplicate or experiment with Home/Onboarding concepts. Prefer the top-level `Modules/Home` and `Modules/Onboarding` packages for production work unless a task explicitly targets these nested packages.

## Dependency Direction

Preferred direction:

```text
Marktek app target
-> feature public factories and assemblies
-> feature Presentation
-> feature Domain
-> feature Data
-> MarktekNetworking / Persistence / external SDKs
```

Feature modules may depend on `Common` for shared stable types. Avoid introducing direct feature-to-feature dependencies unless the relationship is already established and intentional, such as Home/ProductInfo using Favorites, or ProductInfo/Checkout using cart protocols from `Common`.

## Data Flow

Typical Shopify request flow:

```text
SwiftUI View
-> ViewModel
-> UseCase
-> Repository protocol
-> Repository implementation
-> RemoteDataSource
-> ShopifyGraphQLClient or ShopifyAdminGraphQLClient
-> Generated Apollo operation type
-> Shopify API
```

Typical response flow:

```text
Generated GraphQL response
-> Data model
-> Domain entity
-> View model state
-> SwiftUI view
```

GraphQL operation result types should not become app models. Convert them in Data mappers.

## UI Direction

The app uses a warm commerce UI with shared theme assets in `Common`.

Use existing patterns first:

- Shared colors and fonts from `Common/AppTheme.swift`.
- `PriceView` for price display when currency conversion matters.
- Feature-specific controls for repeated patterns inside a feature.
- Loading, empty, and failure states for network-backed screens.
- `AsyncImage` or existing remote image wrappers for product images.

Keep screens practical and shop-focused: searchable lists, product cards, clear price and discount display, obvious cart/favorite actions, and fast navigation to product details.

## GraphQL And Secrets

Shopify and Gemini values are injected through app configuration. Do not hard-code, print, or commit secret values.

Use these docs for GraphQL work:

- `Modules/MarktekNetworking/GRAPHQL_USAGE.md`
- `Modules/MarktekNetworking/GRAPHQL_CODEGEN.md`

When changing a query:

1. Edit or add a `.graphql` operation under `Modules/MarktekNetworking/GraphQL/Queries` or `Modules/MarktekNetworking/GraphQL/Admin`.
2. Regenerate Apollo types from `Modules/MarktekNetworking`.
3. Map generated types to feature data/domain models.
4. Update tests or add focused tests around mapping/use case behavior.

## Testing Strategy

Use focused tests near the changed module.

- For feature package logic: run `swift test` inside that module directory when dependencies allow it.
- For app integration: run the `Marktek` Xcode scheme from `Marktek.xcworkspace`.
- For checkout/payment/order logic: follow the existing style in `Modules/Checkout/Tests/CheckoutTests/CheckoutViewModelPaymentPendingTests.swift`.
- Add tests for new use cases, mappers, repository behavior, and view model state transitions.

When tests cannot run because of simulator, signing, SDK, or secret setup, document the exact command attempted and the failure reason.
