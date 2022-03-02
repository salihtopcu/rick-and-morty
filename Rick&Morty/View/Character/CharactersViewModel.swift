//
//  CharactersViewModel.swift
//  Rick&Morty
//
//  Created by Salih Topcu on 12.02.2022.
//

import Combine

class CharactersViewModel {
    @Published var isLoading: Bool = false
    @Published var characterModels: [CharacterViewModel]?
    
    private var _currentPage: Int?
    var currentPage: Int? {
        get {
            return self._currentPage
        }
        set {
            self._currentPage = newValue
            self.loadCharacters()
        }
    }
    
    var location: Location?
    
    private var listInfo: ApiListInfo?
    private var characters: [Character]?
    
    init(location: Location? = nil) {
        self.location = location
        self.loadCharacters()
    }
    
    func loadCharacters() {
        Character.filter(onSuccess: { [weak self] result in
            self?.listInfo = result.info
            var characters = result.results
            if let loc = self?.location {
                characters = characters.filter {
                    $0.location.id == loc.id
                }
            }
            self?.characterModels = []
            for item in characters {
                self?.characterModels!.append(CharacterViewModel(character: item))
            }
            self?.characters = characters
        }, onFail: { error in
            print(error ?? "error")
        })
    }
}
