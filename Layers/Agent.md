# Layer Guide For AI Agents

This guide defines layer ownership for Marktek feature modules. Use it as the decision table for where code belongs.

## Standard Feature Shape

For substantial features:

```text
Modules/<Feature>/Sources/<Feature>
|-- DI
|-- Data
|-- Domain
`-- Presentation
```

Optional feature folders:

```text
Resources
Tests
```

Small modules may be thinner. Do not create empty layers unless a task is actively adding responsibilities for that layer.

## DI Layer

Purpose: compose dependencies.

Common files:

- `<Feature>DataAssembly.swift`
- `<Feature>DomainAssembly.swift`
- `<Feature>PresentationAssembly.swift`
- `<Feature>ViewModelFactory.swift`
- `<Feature>ViewFactory.swift`
- `<Feature>Assembler.swift` for self-contained package assembly

Allowed:

- Import Swinject.
- Register protocols and concrete implementations.
- Resolve dependencies for factories.
- Expose public view factories and public assemblies needed by the app target.

Not allowed:

- Business rules.
- GraphQL calls.
- Core Data fetch/save logic.
- SwiftUI layout except returning a view from a public factory.
- Mapping generated API types.

Rules:

- Keep concrete views internal when possible.
- Public factories should return `some View`.
- Factory methods that create views or view models should be `@MainActor`.
- Avoid static stored Swinject `Assembler` instances unless concurrency safety is reviewed.

## Presentation Layer

Purpose: render UI and translate user actions into view model calls.

Common files:

- `ViewModels/<Feature>ViewModel.swift`
- `ViewModels/<Feature>ViewState.swift`
- `Views/<Feature>View.swift`
- `Views/Controls`
- `Views/Sections`
- `Views/States`
- `Views/Support`

Allowed:

- SwiftUI views.
- `ObservableObject` view models.
- `@Published` state.
- UI-only formatting helpers.
- Loading, empty, failure, and success state models.
- User action handlers that call use cases.
- Feature-local reusable controls.

Not allowed:

- Direct Shopify GraphQL or Firebase calls.
- Apollo generated response mapping.
- Core Data managed object fetch/save logic.
- Swinject container access from views.
- App-level navigation route mutation.
- Repository implementation details.

Rules:

- Mark view models `@MainActor`.
- Inject use cases, payment authorizers, or other protocols through initializers.
- Keep views declarative; move async decisions to view models.
- Use a single explicit view state enum for simpler screens. For complex screens like checkout, multiple focused state values are acceptable when they match existing code.
- Use `Common` theme tokens when available.
- Feature presentation may depend on Domain and Common. It should not depend on Data.

## Domain Layer

Purpose: model feature concepts and business operations.

Common files:

- `Entities` or `Models`
- `Repositories`
- `UseCases`
- Feature-specific domain errors.

Allowed:

- Domain entities and value objects.
- Repository protocols.
- Use case protocols and implementations.
- Business validation.
- Payment strategy abstractions.
- Cross-feature protocols imported from `Common` when necessary.

Not allowed:

- SwiftUI.
- Swinject.
- Apollo or generated GraphQL types.
- Core Data managed objects.
- Firebase SDK types.
- URLSession or concrete networking.
- View state and UI strings.

Rules:

- Prefer immutable `struct` entities.
- Prefer `Sendable` protocols and models when crossing async boundaries.
- Keep use cases small and testable.
- Use repositories as boundaries between Domain and Data.
- Domain errors should be meaningful to the feature and mapped to UI messages in Presentation.

## Data Layer

Purpose: implement external data access and translate external representations into domain models.

Common files:

- `DataSources`
- `Models`
- `Models/GraphQLMappers`
- `Repositories`
- `Errors`
- `Storage`

Allowed:

- Import `MarktekNetworking`.
- Import `Persistence` or Core Data when implementing storage.
- Import Firebase or Google Sign-In in Authentication data implementations.
- Call `ShopifyGraphQLClient` and `ShopifyAdminGraphQLClient`.
- Use generated Apollo operation result types.
- Define data models.
- Map generated API responses to data models.
- Map data models to domain entities.
- Implement domain repository protocols.

Not allowed:

- SwiftUI.
- View models or view state.
- App navigation.
- Swinject registrations.
- UI formatting.

Rules:

- Keep Apollo generated types at the edge. Do not leak them into Domain or Presentation.
- Put GraphQL response mapping in `GraphQLMappers` or focused mapper extensions.
- Throw meaningful errors; let view models decide display text.
- Keep storage details hidden behind repository protocols.
- Avoid hard-coded secrets, hosts, API versions, or tokens.

## Networking Module

Purpose: own Apollo clients, generated Shopify modules, and GraphQL operations.

Relevant paths:

- `Modules/MarktekNetworking/GraphQL/Queries`
- `Modules/MarktekNetworking/GraphQL/Admin`
- `Modules/MarktekNetworking/Sources/MarktekNetworking`
- `Modules/MarktekNetworking/Sources/ShopifyAPI`
- `Modules/MarktekNetworking/Sources/ShopifyAdminAPI`

Allowed:

- Add or update `.graphql` operations.
- Update Apollo client/interceptor behavior when needed.
- Regenerate generated types using checked-in codegen config.

Not allowed:

- Hand-edit generated operation/schema files.
- Put feature business rules in the networking client.
- Commit local codegen configs containing private values.
- Print secret headers or tokens.

Rules:

- Storefront customer/catalog/cart operations usually belong in `GraphQL/Queries`.
- Admin order/review/discount operations usually belong in `GraphQL/Admin`.
- Feature modules map generated results into their own data/domain models.

## Persistence Module

Purpose: own the Core Data stack.

Relevant paths:

- `Modules/Persistence/Sources/Persistence/Persistence.swift`
- `Modules/Persistence/Sources/Persistence/CoreDataContextProvider.swift`
- `Modules/Persistence/Sources/Persistence/Resources`

Allowed:

- Core Data stack setup.
- Context provider protocols.
- Model resources.

Not allowed:

- Favorites-specific repository logic.
- View models.
- SwiftUI screens.
- Shopify networking.

Rules:

- Feature Data layers should import `Persistence` and map managed data to feature domain entities.
- Keep managed objects out of Domain and Presentation.

## Common Module

Purpose: stable shared app concepts used by multiple modules.

Relevant examples:

- Theme colors and fonts.
- Currency service and price view.
- Cart shared domain models and use case protocols.
- Common error UI.

Allowed:

- Cross-feature value models.
- Cross-feature protocols.
- Reusable UI primitives with no feature-specific business behavior.

Not allowed:

- A dumping ground for one-off helpers.
- Shopify generated types.
- Feature-specific screen state.
- Feature-specific repositories.

Rule of thumb: put something in `Common` only when at least two real modules need the same stable abstraction.

## App Coordination Layer

Purpose: own application navigation and composition.

Relevant paths:

- `Marktek/Application/Coordination`
- `Marktek/Application/AppDIContainer.swift`
- `Marktek/Application/NetworkingAssembly.swift`

Allowed:

- App flow switching.
- Main tab selection.
- Navigation route enums and coordinator methods.
- Resolving public feature factories from the app DI container.
- Passing callbacks into feature views.

Not allowed:

- Feature business logic.
- GraphQL mapping.
- Cart/order/favorites persistence behavior.
- Screen internals that belong in feature modules.

Rules:

- Add routes here when a feature screen becomes reachable from app navigation.
- Keep feature modules route-agnostic by passing closures like `onProductTap`, `onCheckoutTap`, or `onOrderConfirmed`.

## Placement Cheat Sheet

Put new code here:

- New SwiftUI screen: `Modules/<Feature>/Sources/<Feature>/Presentation/Views`.
- New view state: `Presentation/ViewModels`.
- New user action behavior: view model plus use case if business logic is involved.
- New business rule: `Domain/UseCases`.
- New domain data shape: `Domain/Entities` or `Domain/Models`.
- New repository contract: `Domain/Repositories`.
- New Shopify call: `.graphql` operation in `MarktekNetworking`, then Data data source/repository in the feature.
- New API mapper: `Data/Models` or `Data/Models/GraphQLMappers`.
- New Core Data access for a feature: feature `Data` layer, using `Persistence`.
- New DI registration: feature `DI` assembly and app `AppDIContainer` if app-composed.
- New tab or navigation destination: `Marktek/Application/Coordination`.

## Existing Exceptions

Some current modules predate the full reference structure.

- `CheckoutPresentationAssembly` currently registers data, domain, and presentation dependencies together.
- `HomeAssembler` creates a package-local assembler and also includes Favorites domain/data assemblies.
- `FavoritesPresentationAssembly` registers a container-scoped view model.
- `Onboarding` is presentation-only.
- `Settings` is mostly presentation and DI.
- `Authentication` is not fully integrated into the active app flow.

When touching these modules, match the existing local pattern for small changes. For larger refactors, move gradually toward the standard layer ownership without breaking public factories or app wiring.
