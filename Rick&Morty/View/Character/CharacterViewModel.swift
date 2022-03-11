//
//  CharacterViewModel.swift
//  Rick&Morty
//
//  Created by Salih Topcu on 8.03.2022.
//

import Combine

class CharacterViewModel: RoutableViewModel {
    @Published var isLoading: Bool = false
    @Published var nameText: String = ""
    @Published var imageUrl: String?
    
    let characterId: Int
    
    var character: Character? {
        didSet {
            self.nameText = character?.name ?? ""
            self.imageUrl = character?.imageUrl
        }
    }
    
    init(character: Character) {
        self.character = character
        self.characterId = character.id
        self.nameText = character.name
        self.imageUrl = character.imageUrl
    }
    
    init(characterId: Int) {
        self.characterId = characterId
    }
    
    func start() {
        if character == nil {
            Character.find(characterId) { [weak self] result, error in
                self?.character = result
            }
        }
    }
}
