//
//  CharactersViewModelTest.swift
//  Rick&MortyTests
//
//  Created by Salih Topcu on 14.03.2022.
//

import XCTest
@testable import Rick_Morty

class CharactersViewModelTest: XCTestCase {
    
    struct DummyService: Service {
        func filterLocations(page: Int, completion: Completion<ApiList<Location>, Error>?) {}
        
        func findLocation(id: Int, completion: Completion<Location, Error>?) {}
        
        func filterCharacters(page: Int, completion: Completion<ApiList<Character>, Error>?) {
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
        
        func findCharacter(id: Int, completion: Completion<Character, Error>?) {
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
                    created: ""),
                            nil)
            }
        }
        
        func filterEpisodes(page: Int, completion: Completion<ApiList<Episode>, Error>?) {}
        
        func findEpisode(id: Int, completion: Completion<Episode, Error>?) {}
        
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
        vm.loadNextPage(service: DummyService())
        XCTAssertTrue(vm.isLoading)
    }

}

