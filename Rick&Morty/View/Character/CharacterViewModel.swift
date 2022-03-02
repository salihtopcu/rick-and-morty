//
//  CharacterViewModel.swift
//  Rick&Morty
//
//  Created by Salih Topcu on 2.03.2022.
//

import Combine

class CharacterViewModel {
    @Published var nameText: String
    @Published var imageUrl: String
    
    var character: Character
    
    init(character: Character) {
        self.character = character
        self.nameText = character.name
        self.imageUrl = character.imageUrl
    }
}
