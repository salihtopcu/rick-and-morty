//
//  LocationViewModelTest.swift
//  Rick&MortyTests
//
//  Created by Salih Topcu on 11.03.2022.
//

import XCTest
@testable import Rick_Morty

class LocationsViewModelTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func initialState() {
        let vm = LocationsViewModel()
        XCTAssertFalse(vm.isLoading)
        XCTAssertNil(vm.locations)
        XCTAssertNil(vm.currentPage)
        XCTAssertNil(vm.nextPageNumber)
    }
}
