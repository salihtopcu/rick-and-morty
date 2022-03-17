//
//  CharacterCellViewModel.swift
//  Rick&Morty
//
//  Created by Salih Topcu on 2.03.2022.
//

import Combine
import Foundation

class CharacterCellViewModel {
    let characterId: Int
    var nameText: String?
    var imageUrl: URL?
    
    var character: Character?
    
    init(character: Character) {
        self.character = character
        self.characterId = character.id
        self.nameText = character.name
        self.imageUrl = character.imageUrl
    }
}
