//
//  LocationCellViewModelTest.swift
//  Rick&MortyTests
//
//  Created by Salih Topcu on 11.03.2022.
//

import XCTest
@testable import Rick_Morty

class LocationCellViewModelTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_LocationCellViewModel() {
        let location = Location(
            id: 1,
            name: "Name",
            type: "Planet",
            dimension: "Dimension",
            residents: ["Resident1", "Resident2"],
            url: "URL",
            created: "CreatedDate")
        let vm = LocationCellViewModel(location: location)
        XCTAssertEqual(vm.nameText, location.name)
        XCTAssertEqual(vm.residentsCountText, "\(location.residents!.count)")
        XCTAssertEqual(vm.iconName, "globe")
        XCTAssertTrue(vm.isIndicatorVisible)
    }

}
