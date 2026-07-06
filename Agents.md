# AI Agent Instructions

This file tells AI agents how to work safely in the Marktek Shopify iOS repo. Read `Design.md`, `Layers/Agent.md`, and `Modules/ProductInfo/UI_MODULE_STRUCTURE.md` before making architecture-level changes.

## First Moves

Before editing:

- Check `git status --short`.
- Inspect the target module's `Package.swift`.
- Inspect existing files in the same layer and feature.
- Prefer `rg` and `rg --files` for search.
- Treat uncommitted changes as user-owned.
- Do not revert, reformat, or reorganize unrelated files.

If a task is unclear, infer from nearby code and keep the change small. Ask only when a reasonable assumption could damage data, secrets, or public API.

## Project Boundaries

The root app target is `Marktek/`.

Feature packages live under `Modules/`:

- `Authentication`
- `Cart`
- `Checkout`
- `Common`
- `Favorites`
- `Home`
- `MarktekNetworking`
- `Onboarding`
- `Persistence`
- `ProductInfo`
- `Settings`

Do not edit generated or local build artifacts:

- `**/.build/**`
- `**/.swiftpm/**`
- `DerivedData/**`
- `Modules/MarktekNetworking/Sources/ShopifyAPI/**` unless regenerating Apollo output intentionally
- `Modules/MarktekNetworking/Sources/ShopifyAdminAPI/**` unless regenerating Apollo output intentionally
- `*.xcuserdata/**`
- `.DS_Store`

Do not edit secrets unless the task explicitly asks for local configuration changes:

- `Config/**`
- `GoogleService-Info.plist`
- Apollo local codegen configs
- Any file containing Shopify, Firebase, Google, or Gemini keys/tokens

Never print secret values in final answers, logs, comments, docs, tests, screenshots, or generated sample code.

## Coding Style

Follow existing Swift style in the target feature.

- Keep Swift files focused and small enough to scan.
- Use `@MainActor` on SwiftUI view models and UI factories that create UI.
- Keep async work in view models/use cases with clear loading, success, and failure states.
- Prefer immutable structs for data models, domain entities, repositories, and use cases when practical.
- Prefer protocol-based dependencies for use cases, repositories, data sources, payment authorizers, and external services.
- Avoid global mutable state. Existing singletons such as `PersistenceController.shared`, `CurrencyService.shared`, and GraphQL clients are established infrastructure; do not add new singletons casually.
- Do not introduce force unwraps in new code unless matching a local DI registration pattern and the failure is truly programmer error.
- Keep comments sparse and useful.

## Architecture Rules

For substantial features, use:

```text
Sources/<Feature>
|-- DI
|-- Data
|-- Domain
`-- Presentation
```

Use the more detailed rules in `Layers/Agent.md`.

General direction:

- Presentation depends on Domain.
- Domain does not depend on Presentation, Data, DI, SwiftUI, Apollo, Core Data, Firebase, or Swinject.
- Data implements Domain protocols and may depend on MarktekNetworking, Persistence, Firebase, or other external SDKs.
- DI wires concrete implementations to protocols.
- App coordination lives in `Marktek/Application/Coordination`, not inside feature modules.

Public feature surface should stay small:

- Public view factory.
- Public assembly only when the app container needs it.
- Public domain models/protocols only when another module must use them.
- Internal concrete SwiftUI views and implementation details by default.

## Navigation Rules

Feature modules expose screens through factories and callback closures. They should not own app-level `NavigationStack`, tabs, or route enums.

Use app coordinators for navigation:

- `AppFlowCoordinator` switches auth/main.
- `MainFlowCoordinator` owns tab selection.
- Tab coordinators own paths for Home, Cart, Favorites, and Profile.
- `SharedFlowRoute.productInfo` is used for product details reachable from multiple tabs.

When adding a new screen:

1. Add the screen and view model in its feature module.
2. Add a public factory method if another module/app flow must present it.
3. Register the factory/dependencies in the feature DI assembly and `AppDIContainer` if needed.
4. Add app-level route cases and coordinator methods in `Marktek/Application/Coordination`.

## GraphQL Rules

Use Apollo generated operation types correctly.

- Storefront operations go under `Modules/MarktekNetworking/GraphQL/Queries`.
- Admin operations go under `Modules/MarktekNetworking/GraphQL/Admin`.
- Generated operation result types are API DTOs, not app/domain models.
- Add needed fields to `.graphql` operations and regenerate types; do not guess fields in Swift.
- Do not manually edit generated Apollo Swift files.
- Do not manually build variables dictionaries when generated query initializers exist.
- Keep Storefront and Admin responsibilities separate.

Useful commands:

```bash
cd /Users/eslamelnady/Shopify-App/Modules/MarktekNetworking
./apollo-ios-cli generate --path apollo-codegen-config.json
```

Use local schema-fetch configs only on the developer machine and never commit secret-bearing configs.

## Dependency Injection Rules

The app uses Swinject.

- Register data sources and repositories in data assemblies when a module has them.
- Register use cases in domain assemblies.
- Register view model factories and view factories in presentation assemblies.
- Resolve dependencies through factories, not directly inside SwiftUI views.
- Keep factory methods `@MainActor` when they create view models or SwiftUI views.
- Avoid adding long-lived static Swinject assemblers unless concurrency safety is understood.

Some existing modules compose differently. Match the local pattern when making a small change; move toward the reference structure when creating a new major feature.

## UI Rules

Use existing SwiftUI and app theme conventions.

- Use colors/fonts from `Common/AppTheme.swift` when a module imports `Common`.
- Use feature-local controls for repeated feature-specific UI.
- Prefer clear loading, empty, failure, and success states.
- Keep commerce actions obvious: favorite, add to cart, checkout, quantity, discount, search, filter, sort.
- Do not add marketing landing pages inside the app.
- Keep text short and local to the UI surface; put reusable strings in feature string helpers when patterns already exist.
- Test previews or screens mentally against small iPhone layouts; avoid fixed widths that clip common product names or prices.

## Persistence Rules

Use `Persistence` for Core Data stack access.

- Feature storage behavior belongs in the feature Data layer.
- Do not put feature-specific Core Data logic in `Persistence`.
- Prefer background contexts for nontrivial writes.
- Keep managed objects out of Domain and Presentation; map to domain entities or view state.

## Tests And Verification

Pick the narrowest useful verification.

For package tests:

```bash
cd /Users/eslamelnady/Shopify-App/Modules/<ModuleName>
swift test
```

For app tests/builds, use the workspace and scheme:

```bash
xcodebuild -workspace /Users/eslamelnady/Shopify-App/Marktek.xcworkspace -scheme Marktek -destination 'platform=iOS Simulator,name=iPhone 15' build
```

Use an available simulator name if the listed one is not installed.

Add focused tests when changing:

- Use case business rules.
- GraphQL/data mappers.
- Repository error handling.
- View model loading/success/failure transitions.
- Payment, checkout, order, cart reset, or favorites behavior.

If verification cannot run, report exactly what was attempted and why it failed.

## Documentation Rules

Update docs when changing architecture or workflow.

- Update `Design.md` when modules, app flow, or major feature responsibilities change.
- Update `Layers/Agent.md` when layer rules change.
- Update `Agents.md` when agent workflow, safety, or verification rules change.
- Keep docs factual. Do not include private tokens, credentials, or environment-only values.

## When In Doubt

Prefer the smallest change that fits the existing module.

- New business logic belongs in Domain.
- New API or database code belongs in Data.
- New screen state and SwiftUI belongs in Presentation.
- New dependency wiring belongs in DI.
- New app route behavior belongs in `Marktek/Application/Coordination`.
- New shared type belongs in `Common` only if multiple features truly need the same stable concept.
