//
//  CharacterCollectionViewCell.swift
//  Rick&Morty
//
//  Created by Salih Topcu on 3.03.2022.
//

import UIKit

class CharacterCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    func use(_ viewModel: CharacterViewModel) {
        self.nameLabel.text = viewModel.nameText
        if let url = URL(string: viewModel.imageUrl) {
            do {
                self.imageView.image = try UIImage(data: Data(contentsOf: url))
            } catch {
                print(error)
            }
        }
    }
}
