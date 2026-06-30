import XCTest
@testable import Persistence

final class PersistenceTests: XCTestCase {
    func testInMemoryContainerLoadsModel() throws {
        let controller = PersistenceController(inMemory: true)

        XCTAssertNotNil(controller.container.managedObjectModel.entitiesByName["Item"])
    }
}
