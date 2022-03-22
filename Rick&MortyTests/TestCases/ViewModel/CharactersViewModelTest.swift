//
//  CharactersViewModelTest.swift
//  Rick&MortyTests
//
//  Created by Salih Topcu on 14.03.2022.
//

import XCTest
@testable import Rick_Morty

class CharactersViewModelTest: XCTestCase {
    
    struct DummyApi: CharacterApi {
        func filter(page: Int, completion: Completion<ApiList<Character>, Error>?) {
            delay(bySeconds: 1, dispatchLevel: .background) {
                completion?(ApiList(
                    info: ApiListInfo(
                        count: 0,
                        pages: 1,
                        next: nil,
                        prev: nil),
                    results: []), nil)
            }
        }
        
        func find(id: Int, completion: Completion<Character, Error>?) {
            delay(bySeconds: 1, dispatchLevel: .background) {
                completion?(Character(
                    id: 0,
                    name: "",
                    status: "",
                    species: .unknown,
                    type: "",
                    gender: "",
                    origin: nil,
                    location: nil,
                    imageUrl: nil,
                    episodeUrls: [],
                    url: URL(string: "https://www.google.com")!,
                    created: Date()),
                            nil)
            }
        }
    }

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_initialState() {
        let vm = CharactersViewModel()
        XCTAssertFalse(vm.isLoading)
        XCTAssertNil(vm.characterViewModels)
    }
    
    func test_loadNextPage() {
        let vm = CharactersViewModel()
        vm.loadNextPage(api: DummyApi())
        XCTAssertTrue(vm.isLoading)
    }

}


