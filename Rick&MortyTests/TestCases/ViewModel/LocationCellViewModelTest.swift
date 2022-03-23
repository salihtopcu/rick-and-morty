//
//  LocationCellViewModelTest.swift
//  Rick&MortyTests
//
//  Created by Salih Topcu on 11.03.2022.
//

import XCTest
@testable import Rick_Morty

class LocationCellViewModelTest: XCTestCase {
    var vm1: LocationCellViewModel!
    var vm2: LocationCellViewModel!
    var vmList: [LocationCellViewModel]!

    override func setUpWithError() throws {
        let formatter = Foundation.DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(formatter)
        
        let location1Data = loadStub(name: "location_1", extension: "json")
        let location1 = try decoder.decode(Location.self, from: location1Data)
        vm1 = LocationCellViewModel(location: location1)
        
        let location2Data = loadStub(name: "location_2", extension: "json")
        let location2 = try decoder.decode(Location.self, from: location2Data)
        vm2 = LocationCellViewModel(location: location2)
        
        let locationListData = loadStub(name: "locations_page1", extension: "json")
        let locationList = try decoder.decode(ApiList<Location>.self, from: locationListData)
        vmList = locationList.results.map({ return LocationCellViewModel(location: $0) })
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_nameText() {
        XCTAssertEqual(vm1.nameText, vm1.location.name)
    }
    
    func test_residentsCountText() {
        XCTAssertEqual(vm1.residentsCountText, "\(vm1.location.residents!.count)")
        XCTAssertEqual(vm2.residentsCountText, "")
    }
    
    func test_iconNames() {
        for item in vmList {
            switch item.location.type {
            case .planet: XCTAssertEqual(item.iconName, "globe"); break
            case .cluster: XCTAssertEqual(item.iconName, "circles.hexagonpath.fill"); break
            case .spaceStation: XCTAssertEqual(item.iconName, "logo.xbox"); break
            case .microverse: XCTAssertEqual(item.iconName, "homepodmini.fill"); break
            case .tv: XCTAssertEqual(item.iconName, "sparkles.tv.fill"); break
            case .resort: XCTAssertEqual(item.iconName, "sleep.circle.fill"); break
            default:  XCTAssertEqual(item.iconName, "questionmark")
            }
        }
    }
    
    func test_indicatorVisibality() {
        XCTAssertTrue(vm1.isIndicatorVisible)
        XCTAssertFalse(vm2.isIndicatorVisible)
    }
}
