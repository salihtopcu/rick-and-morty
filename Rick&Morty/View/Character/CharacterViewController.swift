//
//  CharacterViewController.swift
//  Rick&Morty
//
//  Created by Salih Topcu on 6.03.2022.
//

import UIKit

class CharacterViewController: RoutableViewController<CharacterViewModel> {
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel?.start()
    }
}
