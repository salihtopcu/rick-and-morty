//
//  Base.swift
//  Rick&Morty
//
//  Created by Salih Topcu on 8.03.2022.
//

import UIKit

class CharactersRouter: Router<CharactersViewModel> {
    
    func routeForCharacterSelection(id: Int) {
        let vc = AppDelegate.mainStoryboard
            .instantiateViewController(withIdentifier: "CharacterViewController") as! CharacterViewController
        vc.viewModel = CharacterViewModel(characterId: id)
        context.showDetailViewController(vc, sender: context)
    }
    
}
