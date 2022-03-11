//
//  CharacterCellViewModel.swift
//  Rick&Morty
//
//  Created by Salih Topcu on 2.03.2022.
//

import Combine

class CharacterCellViewModel {
    let characterId: Int
    @Published var nameText: String?
    @Published var imageUrl: String?
    
    var character: Character?
    
    init(character: Character) {
        self.character = character
        self.characterId = character.id
        self.nameText = character.name
        self.imageUrl = character.imageUrl
    }
}
