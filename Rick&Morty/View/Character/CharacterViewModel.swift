//
//  CharacterViewModel.swift
//  Rick&Morty
//
//  Created by Salih Topcu on 8.03.2022.
//

import Combine
import Foundation

class CharacterViewModel: RoutableViewModel {
    @Published var isLoading: Bool = false
    @Published var nameText: String = ""
    @Published var imageUrl: URL?
    
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
            loadCharacter()
        }
    }
    
    func loadCharacter(api: CharacterApi = Service.shared.characters) {
        self.isLoading = true
        api.find(id: characterId) { [weak self] item, error in
            self?.isLoading = false
            if item != nil {
                self?.character = item
            } else if error != nil {
                print(error ?? "error")
            }
        }
    }
}
