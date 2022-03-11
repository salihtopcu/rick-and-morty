//
//  CharactersViewModel.swift
//  Rick&Morty
//
//  Created by Salih Topcu on 12.02.2022.
//

import Combine

class CharactersViewModel: RoutableViewModel {
    @Published var isLoading: Bool = false
    @Published var characterModels: [CharacterCellViewModel]?
    
    private var _currentPage: Int?
    var currentPage: Int? {
        get {
            return self._currentPage
        }
        set {
            self._currentPage = newValue
            if let val = newValue {
                loadCharacters(page: val)
            } else {
                characterModels = nil
            }
        }
    }
    
    var location: Location?
    
    private var listInfo: ApiListInfo?
    private var characters: [Character]?
    
    init(location: Location? = nil) {
        self.location = location
    }
    
    func start() {
        self.currentPage = 1
    }
    
    private func loadCharacters(page: Int) {
        self.isLoading = true
        Character.filter(
            page: page,
            onSuccess: { [weak self] result in
                self?.listInfo = result.info
                var characters = result.results
                if let loc = self?.location {
                    characters = characters.filter {
                        $0.location.id == loc.id
                    }
                }
                self?.characterModels = result.results.map({ return CharacterCellViewModel(character: $0) })
                self?.characters = characters
                self?.isLoading = false
            },
            onFail: { [weak self] error in
                print(error ?? "error")
                self?.isLoading = false
            })
    }
}
