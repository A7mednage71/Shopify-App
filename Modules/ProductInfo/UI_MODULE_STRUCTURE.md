# UI Module Structure

Use this document as a generic guide for building SwiftUI feature modules with clean architecture, Swinject dependency injection, and Swift Package Manager. It is intended for humans and AI agents creating future UI modules.

Replace names like `<FeatureName>`, `<Entity>`, and `<OperationQuery>` with the actual feature names.

## Target Shape

Each UI feature module should be a Swift package under:

```text
Modules/<FeatureName>
```

Source layout:

```text
Sources/<FeatureName>
├── DI
├── Data
├── Domain
└── Presentation
```

Recommended folders:

```text
DI
├── <FeatureName>Assembler.swift
├── <FeatureName>DataAssembly.swift
├── <FeatureName>DomainAssembly.swift
├── <FeatureName>PresentationAssembly.swift
└── <FeatureName>ViewFactory.swift

Data
├── DataSources
├── Errors
├── Models
└── Repositories

Domain
├── Entities
├── Repositories
└── UseCases

Presentation
├── ViewModels
└── Views
```

## Public Surface

Expose as little as possible.

Public:

- `<FeatureName>ViewFactory`
- `<FeatureName>ViewModel` only if another module needs to own it directly
- `<FeatureName>ViewState` if exposed by the view model
- domain entities used by public state, such as `<Entity>`

Internal:

- concrete SwiftUI view
- Swinject assemblies
- assembler
- view model factory
- data sources
- repository implementations
- use cases
- repository protocols
- data models
- mapper extensions
- feature-specific errors

The concrete SwiftUI view should usually be internal:

```swift
struct <FeatureName>View: View {
    // ...
}
```

The public factory should return an opaque view:

```swift
public enum <FeatureName>ViewFactory {
    @MainActor
    public static func make<FeatureName>View(input: <Input>) -> some View {
        let viewModelFactory = <FeatureName>Assembler.resolveViewModelFactory()

        return <FeatureName>View(
            input: input,
            viewModel: viewModelFactory.makeViewModel()
        )
    }
}
```

This keeps the concrete view hidden while still allowing other modules to display the feature.

## Dependency Injection

Use Swinject assemblies grouped by architecture layer.

Data assembly registers data sources and repository implementations:

```swift
import Swinject

struct <FeatureName>DataAssembly: Assembly {
    func assemble(container: Container) {
        container.register(<FeatureName>RemoteDataSource.self) { _ in
            <API><FeatureName>RemoteDataSource()
        }

        container.register((any <FeatureName>Repository).self) { resolver in
            <FeatureName>RepositoryImpl(
                remoteDataSource: resolver.resolve(<FeatureName>RemoteDataSource.self)!
            )
        }
    }
}
```

Domain assembly registers use cases:

```swift
import Swinject

struct <FeatureName>DomainAssembly: Assembly {
    func assemble(container: Container) {
        container.register(Get<FeatureName>UseCaseProtocol.self) { resolver in
            Get<FeatureName>UseCase(
                repository: resolver.resolve((any <FeatureName>Repository).self)!
            )
        }
    }
}
```

Presentation assembly registers an internal view model factory:

```swift
import Swinject

struct <FeatureName>PresentationAssembly: Assembly {
    func assemble(container: Container) {
        container.register(<FeatureName>ViewModelFactory.self) { resolver in
            <FeatureName>ViewModelFactory(
                get<FeatureName>UseCase: resolver.resolve(Get<FeatureName>UseCaseProtocol.self)!
            )
        }
    }
}
```

Assembler composes all assemblies:

```swift
import Swinject

enum <FeatureName>Assembler {
    static func resolveViewModelFactory() -> <FeatureName>ViewModelFactory {
        makeAssembler().resolver.resolve(<FeatureName>ViewModelFactory.self)!
    }

    private static func makeAssembler() -> Assembler {
        Assembler([
            <FeatureName>DataAssembly(),
            <FeatureName>DomainAssembly(),
            <FeatureName>PresentationAssembly(),
        ])
    }
}
```

Avoid storing a static `Assembler` unless concurrency is handled intentionally. In Swift 6, Swinject's `Assembler` is not `Sendable`, so a static shared assembler can trigger concurrency-safety errors.

## Data Flow

Request flow:

```text
<FeatureName>ViewFactory
-> <FeatureName>Assembler
-> <FeatureName>ViewModelFactory
-> <FeatureName>View
-> <FeatureName>ViewModel.load(...)
-> Get<FeatureName>UseCase.execute(...)
-> <FeatureName>Repository.fetch(...)
-> <FeatureName>RepositoryImpl
-> <FeatureName>RemoteDataSource.fetch(...)
-> API client / networking package
-> backend
```

Response flow:

```text
Generated/API response DTO
-> Data model
-> Domain entity
-> <FeatureName>ViewState.success(entity)
-> <FeatureName>View renders UI
```

Failure flow:

```text
Network/API/mapping error
-> thrown error
-> <FeatureName>ViewModel catches error
-> <FeatureName>ViewState.failure(message)
-> <FeatureName>View renders failure state
```

## Layer Rules

### DI

DI owns composition only.

Allowed:

- import Swinject
- register services
- resolve factories

Not allowed:

- business logic
- mapping logic
- networking calls
- SwiftUI screen layout, except the public factory returning the view

### Data

Data owns API-facing implementation details.

Allowed:

- import the networking package
- call generated GraphQL queries or REST clients
- define data models
- map API responses into data models
- map data models into domain entities
- implement domain repository protocols

Not allowed:

- SwiftUI
- view state
- direct view model usage

### Domain

Domain owns feature concepts and business operations.

Allowed:

- entities
- repository protocols
- use case protocols
- use case implementations

Not allowed:

- SwiftUI
- Swinject
- Apollo/generated GraphQL types
- networking package imports

### Presentation

Presentation owns UI state, view models, and views.

Allowed:

- SwiftUI views
- ObservableObject view models
- state enums
- view model factories

Not allowed:

- direct GraphQL/API calls
- data source construction
- repository implementation details

## View State Pattern

Use one state value on the view model.

Recommended:

```swift
public enum <FeatureName>ViewState: Equatable {
    case idle
    case loading
    case success(<Entity>)
    case failure(String)
}
```

For Swift 6 concurrency, prefer:

```swift
public enum <FeatureName>ViewState: Equatable, Sendable {
    case idle
    case loading
    case success(<Entity>)
    case failure(String)
}
```

View model:

```swift
@MainActor
public final class <FeatureName>ViewModel: ObservableObject {
    @Published public private(set) var state: <FeatureName>ViewState = .idle

    private let useCase: any Get<FeatureName>UseCaseProtocol

    init(useCase: any Get<FeatureName>UseCaseProtocol) {
        self.useCase = useCase
    }

    public func load(input: <Input>) async {
        state = .loading

        do {
            let entity = try await useCase.execute(input: input)
            state = .success(entity)
        } catch {
            state = .failure(error.localizedDescription)
        }
    }
}
```

Notes:

- Keep `@MainActor` on the view model.
- Do not put `@MainActor` on data sources, repositories, or use cases unless there is a deliberate UI-thread reason.
- Do not use `nonisolated(unsafe)` for injected dependencies.
- Do not use `@unchecked Sendable` unless there is no cleaner option and the safety has been reviewed.

## Sendable Dependencies

Swift 6 requires dependencies stored inside a `@MainActor` view model to be safe to cross concurrency boundaries. Prefer `Sendable` protocols and immutable value-type implementations.

Use this shape for protocols:

```swift
protocol Get<FeatureName>UseCaseProtocol: Sendable {
    func execute(input: <Input>) async throws -> <Entity>
}

protocol <FeatureName>Repository: Sendable {
    func fetch(input: <Input>) async throws -> <Entity>
}

protocol <FeatureName>RemoteDataSource: Sendable {
    func fetch(input: <Input>) async throws -> <FeatureName>DataModel
}
```

Use structs for implementations when possible:

```swift
struct Get<FeatureName>UseCase: Get<FeatureName>UseCaseProtocol, Sendable {
    private let repository: any <FeatureName>Repository

    init(repository: any <FeatureName>Repository) {
        self.repository = repository
    }

    func execute(input: <Input>) async throws -> <Entity> {
        try await repository.fetch(input: input)
    }
}

struct <FeatureName>RepositoryImpl: <FeatureName>Repository, Sendable {
    private let remoteDataSource: any <FeatureName>RemoteDataSource

    init(remoteDataSource: any <FeatureName>RemoteDataSource) {
        self.remoteDataSource = remoteDataSource
    }

    func fetch(input: <Input>) async throws -> <Entity> {
        try await remoteDataSource.fetch(input: input).toDomain()
    }
}

struct <API><FeatureName>RemoteDataSource: <FeatureName>RemoteDataSource, Sendable {
    func fetch(input: <Input>) async throws -> <FeatureName>DataModel {
        // Call API client here.
    }
}
```

Entities and data models that cross async boundaries should also be immutable and `Sendable`:

```swift
public struct <Entity>: Equatable, Sendable {
    public let id: String
}

struct <FeatureName>DataModel: Sendable {
    let id: String
}
```

If an API client is a shared reference type from another module, avoid storing it in the data source unless it is `Sendable`. Prefer calling its singleton at the call site, or update the networking module to provide a concurrency-safe abstraction.

## GraphQL Variables

Dynamic request inputs should be GraphQL variables.

Example operation:

```graphql
query GetEntity($id: ID!) {
  entity(id: $id) {
    id
    title
  }
}
```

Generated usage:

```swift
let data = try await client.fetch(GetEntityQuery(id: id))
```

Do not manually send a variables dictionary when using generated Apollo query types. Pass variables to the generated query initializer.

## Package Dependency Setup

### Creating A Feature Module

Example `Modules/<FeatureName>/Package.swift`:

```swift
// swift-tools-version: 6.3

import PackageDescription

let package = Package(
    name: "<FeatureName>",
    platforms: [
        .iOS(.v15),
    ],
    products: [
        .library(
            name: "<FeatureName>",
            targets: ["<FeatureName>"]
        ),
    ],
    dependencies: [
        .package(path: "../<NetworkingModule>"),
        .package(url: "https://github.com/Swinject/Swinject.git", from: "2.10.0"),
    ],
    targets: [
        .target(
            name: "<FeatureName>",
            dependencies: [
                .product(name: "<NetworkingModule>", package: "<NetworkingModule>"),
                .product(name: "Swinject", package: "Swinject"),
            ]
        ),
        .testTarget(
            name: "<FeatureName>Tests",
            dependencies: ["<FeatureName>"]
        ),
    ],
    swiftLanguageModes: [.v6]
)
```

### Depending On A Feature Module From Another Module

Example layout:

```text
Modules
├── <FeatureName>
└── <ConsumerFeature>
```

In `Modules/<ConsumerFeature>/Package.swift`:

```swift
dependencies: [
    .package(path: "../<FeatureName>"),
],
targets: [
    .target(
        name: "<ConsumerFeature>",
        dependencies: [
            .product(name: "<FeatureName>", package: "<FeatureName>"),
        ]
    ),
]
```

Usage:

```swift
import <FeatureName>
import SwiftUI

struct <ConsumerFeature>View: View {
    let input: <Input>

    var body: some View {
        <FeatureName>ViewFactory.make<FeatureName>View(input: input)
    }
}
```

## AI Agent Checklist

When creating or updating a UI module:

1. Keep source folders at `DI`, `Data`, `Domain`, and `Presentation`.
2. Keep the concrete SwiftUI view internal.
3. Expose a public view factory returning `some View`.
4. Register dependencies through three assemblies: Data, Domain, Presentation.
5. Keep Domain free of SwiftUI, Swinject, networking clients, and generated API types.
6. Keep generated API response types inside Data.
7. Map API response -> data model -> domain entity.
8. Use one view model state value.
9. Keep `@MainActor` on the view model, not on lower layers by default.
10. Run `swift test` from the module directory after changes.
