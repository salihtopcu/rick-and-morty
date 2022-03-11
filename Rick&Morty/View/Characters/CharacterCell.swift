//
//  CharacterCollectionViewCell.swift
//  Rick&Morty
//
//  Created by Salih Topcu on 3.03.2022.
//

import UIKit

class CharacterCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    func use(_ viewModel: CharacterCellViewModel) {
        self.nameLabel.text = viewModel.nameText
        if let urlString = viewModel.imageUrl, let url = URL(string: urlString) {
            do {
                self.imageView.image = try UIImage(data: Data(contentsOf: url))
            } catch {
                print(error)
            }
        }
    }
}
