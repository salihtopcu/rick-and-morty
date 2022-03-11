//
//  LocationCell.swift
//  Rick&Morty
//
//  Created by Salih Topcu on 3.03.2022.
//

import UIKit

class LocationCell: UITableViewCell {
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var characterCountLabel: UILabel!
    
    func use(_ viewModel: LocationCellViewModel) {
        self.nameLabel.text = viewModel.nameText
        self.characterCountLabel.text = "\(viewModel.residentsCountText)"
        self.accessoryType = viewModel.isIndicatorVisible ? .disclosureIndicator : .none
        self.imageView?.image = UIImage.init(systemName: viewModel.iconName)
        self.imageView?.tintColor = UIColor.init(named: "ContentIcon")
    }
}
