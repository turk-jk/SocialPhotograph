//
//  AddingLocationNewViewModelTests.swift
//  SocialPhotographTests
//
//  Created by yacob kazal on 16/10/2023.
//

import CoreData
import XCTest
@testable import SocialPhotograph

final class AddingLocationNewViewModelTests: XCTestCase {
    var viewModel: AddingLocationNewViewModel!
    var persistenceController: PersistenceController!
    override func setUp() {
        super.setUp()
        persistenceController = .init(inMemory: false)
        viewModel = AddingLocationNewViewModel(viewContext: persistenceController.container.viewContext)
    }

    override func tearDown() {
        viewModel = nil
        persistenceController.deleteAllLocations()
        persistenceController = nil
        super.tearDown()
    }

    func testShouldShowSavingButtonIsFalse(){
        viewModel.name = ""
        viewModel.note = ""
        viewModel.lat = 0
        viewModel.lng = 0
        XCTAssertFalse(viewModel.shouldShowSavingButton)
        viewModel.name = "Manly Beach"
        viewModel.note = ""
        viewModel.lat = -33.797151
        viewModel.lng = 151.288784
        XCTAssertTrue(viewModel.shouldShowSavingButton)
    }
    
    func testSaving(){
        viewModel.name = "Manly Beach"
        viewModel.note = ""
        viewModel.lat = -33.797151
        viewModel.lng = 151.288784
        viewModel.save()
        let fetchedLocations = try? persistenceController.container.viewContext.fetch(Location.fetchRequest())
        XCTAssertEqual(fetchedLocations?.count, 1)
        XCTAssertEqual(fetchedLocations?.first?.name, "Manly Beach")
        XCTAssertEqual(fetchedLocations?.first?.note, "")
        XCTAssertEqual(fetchedLocations?.first?.lat, -33.797151)
        XCTAssertEqual(fetchedLocations?.first?.lng, 151.288784)
    }
}
