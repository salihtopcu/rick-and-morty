//
//  CharacterCellViewModelTest.swift
//  Rick&MortyTests
//
//  Created by Salih Topcu on 24.03.2022.
//

import XCTest
@testable import Rick_Morty

class CharacterCellViewModelTest: XCTestCase {
    var vm: CharacterCellViewModel!
    
    override func setUpWithError() throws {
        let formatter = Foundation.DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(formatter)
        
        let character1Data = loadStub(name: "character_1", extension: "json")
        let character1 = try decoder.decode(Character.self, from: character1Data)
        vm = CharacterCellViewModel(character: character1)
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_characterId() {
        XCTAssertEqual(vm.characterId, vm.character!.id)
    }
    
    func test_nameText() {
        XCTAssertEqual(vm.nameText, vm.character!.name)
    }
    
    func test_imageUrl() {
        XCTAssertEqual(vm.imageUrl, vm.character!.imageUrl)
    }
}
