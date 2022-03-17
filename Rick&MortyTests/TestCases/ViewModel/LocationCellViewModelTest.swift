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

    func test_initialState() {
        let location = Location(
            id: 1,
            name: "Name",
            type: .planet,
            dimension: "Dimension",
            residents: [URL(string: "https://www.google.com")!],
            urlString: "URL",
            created: "CreatedDate")
        let vm = LocationCellViewModel(location: location)
        XCTAssertEqual(vm.nameText, location.name)
        XCTAssertEqual(vm.residentsCountText, "\(location.residents!.count)")
        XCTAssertEqual(vm.iconName, "globe")
        XCTAssertTrue(vm.isIndicatorVisible)
    }
    
    func test_iconNames() {
        let vmPlanet = LocationCellViewModel(
            location: Location(
                id: nil,
                name: "",
                type: .planet,
                dimension: nil,
                residents: nil,
                urlString: "",
                created: nil))
        XCTAssertEqual(vmPlanet.iconName, "globe")
        
        let vmCluster = LocationCellViewModel(
            location: Location(
                id: nil,
                name: "",
                type: .cluster,
                dimension: nil,
                residents: nil,
                urlString: "",
                created: nil))
        XCTAssertEqual(vmCluster.iconName, "circles.hexagonpath.fill")
        
        let vmSpaceStation = LocationCellViewModel(
            location: Location(
                id: nil,
                name: "",
                type: .spaceStation,
                dimension: nil,
                residents: nil,
                urlString: "",
                created: nil))
        XCTAssertEqual(vmSpaceStation.iconName, "logo.xbox")
        
        let vmMicroverse = LocationCellViewModel(
            location: Location(
                id: nil,
                name: "",
                type: .microverse,
                dimension: nil,
                residents: nil,
                urlString: "",
                created: nil))
        XCTAssertEqual(vmMicroverse.iconName, "homepodmini.fill")
        
        let vmTv = LocationCellViewModel(
            location: Location(
                id: nil,
                name: "",
                type: .tv,
                dimension: nil,
                residents: nil,
                urlString: "",
                created: nil))
        XCTAssertEqual(vmTv.iconName, "sparkles.tv.fill")
        
        let vmResort = LocationCellViewModel(
            location: Location(
                id: nil,
                name: "",
                type: .resort,
                dimension: nil,
                residents: nil,
                urlString: "",
                created: nil))
        XCTAssertEqual(vmResort.iconName, "sleep.circle.fill")
        
        let vmOther = LocationCellViewModel(
            location: Location(
                id: nil,
                name: "",
                type: .unknown,
                dimension: nil,
                residents: nil,
                urlString: "",
                created: nil))
        XCTAssertEqual(vmOther.iconName, "questionmark")
    }
}
