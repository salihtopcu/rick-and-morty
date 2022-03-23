//
//  CharactersViewModelTest.swift
//  Rick&MortyTests
//
//  Created by Salih Topcu on 14.03.2022.
//

import XCTest
@testable import Rick_Morty

class CharactersViewModelTest: XCTestCase {
    var vm: CharactersViewModel!
    var list1: ApiList<Character>!
    var list2: ApiList<Character>!
    
    struct DummyApi: CharacterApi {
        var list1: ApiList<Character>!
        var list2: ApiList<Character>!
        
        init(list1: ApiList<Character>, list2: ApiList<Character>) {
            self.list1 = list1
            self.list2 = list2
        }
        
        func filter(page: Int, completion: Completion<ApiList<Character>, Error>?) {
            delay(bySeconds: 1, dispatchLevel: .background) {
                if page == 1 {
                    completion!(list1, nil)
                } else if page == 2 {
                    completion!(list2, nil)
                } else {
                    completion!(nil, nil)
                }
            }
        }
        
        func find(id: Int, completion: Completion<Character, Error>?) {}
    }
    
    override func setUpWithError() throws {
        let formatter = Foundation.DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(formatter)
        
        let characterList1Data = loadStub(name: "characters_page1", extension: "json")
        list1 = try decoder.decode(ApiList<Character>.self, from: characterList1Data)
        
        let characterList2Data = loadStub(name: "characters_page2", extension: "json")
        list2 = try decoder.decode(ApiList<Character>.self, from: characterList2Data)
        
        vm = CharactersViewModel(api: DummyApi(list1: list1, list2: list2))
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_initialState() {
        XCTAssertFalse(vm.isLoading)
        XCTAssertNil(vm.characterViewModels)
    }
    
    func test_start_loadNextPage() {
        print("test_start")
        vm.start()
        XCTAssertTrue(vm.isLoading)
        let exp1 = expectation(description: "load first page with start")
        if XCTWaiter.wait(for: [exp1], timeout: 1.1) == .timedOut {
            XCTAssertFalse(vm.isLoading)
            XCTAssertEqual(vm.characterViewModels!.count, list1.results.count)
        } else {
            XCTFail("FAIL: test_start")
        }
        
        print("test_loadNextPage")
        vm.loadNextPage()
        XCTAssertTrue(vm.isLoading)
        let exp2 = expectation(description: "load next page")
        if XCTWaiter.wait(for: [exp2], timeout: 1.1) == .timedOut {
            XCTAssertFalse(vm.isLoading)
            XCTAssertEqual(vm.characterViewModels!.count, list1.results.count + list2.results.count)
        } else {
            XCTFail("FAIL: test_loadNextPage")
        }
        
        print("test_loadNextPage")
        vm.loadNextPage()
        XCTAssertFalse(vm.isLoading)
    }
}
