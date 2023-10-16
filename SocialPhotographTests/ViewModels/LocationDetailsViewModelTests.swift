//
//  LocationDetailsViewModelTests.swift
//  SocialPhotographTests
//
//  Created by yacob kazal on 16/10/2023.
//

import CoreData
import XCTest
@testable import SocialPhotograph

final class LocationDetailsViewModelTests: XCTestCase {
    var viewModel: LocationDetailsViewModel!
    var location: Location!
    var persistenceController: PersistenceController!
    override func setUp() {
        super.setUp()
        persistenceController = .init(inMemory: false)
        location = .init(locationModel: TestData.locationModel, viewContext: persistenceController.container.viewContext)
        viewModel = LocationDetailsViewModel(location: location)
    }
    override func tearDown() {
        viewModel = nil
        location = nil
        persistenceController.deleteAllLocations()
        persistenceController = nil
    }

    func testLocationData() {
        XCTAssertEqual(location.name, "Manly Beach")
        XCTAssertEqual(location.note, "")
        XCTAssertEqual(location.lat, -33.797151)
        XCTAssertEqual(location.lng, 151.288784)
    }

    func testOnAppear() {
        XCTAssertEqual(viewModel.name, "")
        XCTAssertEqual(viewModel.note, "")
        XCTAssertEqual(viewModel.lat, 0)
        XCTAssertEqual(viewModel.lng, 0)
        viewModel.onAppear()
        XCTAssertEqual(viewModel.name, location.name)
        XCTAssertEqual(viewModel.note, location.note)
        XCTAssertEqual(viewModel.lat, location.lat)
        XCTAssertEqual(viewModel.lng, location.lng)
    }

    func testShouldShowSavingButtonIsFalse(){
        viewModel.onAppear()
        XCTAssertFalse(viewModel.shouldShowSavingButton)
        viewModel.name.removeLast()
        XCTAssertTrue(viewModel.shouldShowSavingButton)
    }
    
    func testSaving(){
        XCTAssertEqual(location.name, "Manly Beach")
        viewModel.onAppear()
        viewModel.name = "NewName"
        viewModel.save()
        XCTAssertEqual(location.name, "NewName")
    }
}
