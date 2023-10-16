//
//  PersistenceControllerTests.swift
//  SocialPhotographTests
//
//  Created by yacob kazal on 16/10/2023.
//

import CoreData
import XCTest
@testable import SocialPhotograph

final class PersistenceControllerTests: XCTestCase {
    var persistenceController: PersistenceController!
    override func setUp() {
        super.setUp()
        persistenceController = .init(inMemory: false)
    }
    override func tearDown() {
        persistenceController.deleteAllLocations()
        persistenceController = nil
    }

    func testDeleteAllLocations() {
        guard let viewContext = persistenceController?.container.viewContext else {
            XCTFail("ViewContext is not initialized")
            return
        }
        
        let fetchedLocationsBeforeSaving = try? viewContext.fetch(Location.fetchRequest())
        XCTAssertEqual(fetchedLocationsBeforeSaving?.count, 0)

        let location = Location(context: viewContext)
        location.name = "Manly Beach"
        location.lat = -33.797151
        location.lng = 151.288784
        location.note = ""
        XCTAssertNoThrow(
            try viewContext.save()
        )
        
        let fetchedLocationsBeforeDeletion = try? viewContext.fetch(Location.fetchRequest())
        XCTAssertEqual(fetchedLocationsBeforeDeletion?.count, 1)
        XCTAssertEqual(fetchedLocationsBeforeDeletion?.first?.name, "Manly Beach")
        XCTAssertEqual(fetchedLocationsBeforeDeletion?.first?.note, "")
        XCTAssertEqual(fetchedLocationsBeforeDeletion?.first?.lat, -33.797151)
        XCTAssertEqual(fetchedLocationsBeforeDeletion?.first?.lng, 151.288784)
        
        persistenceController.deleteAllLocations()
        let fetchedLocationsAfterDeletion = try? viewContext.fetch(Location.fetchRequest())
        XCTAssertEqual(fetchedLocationsAfterDeletion?.count, 0)
    }
}
