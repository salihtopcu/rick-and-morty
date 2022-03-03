//
//  CharactersViewController.swift
//  Rick&Morty
//
//  Created by Salih Topcu on 10.02.2022.
//

import UIKit
import Combine

class CharactersViewController: UIViewController {

    @IBOutlet weak var charactersCollectionView: UICollectionView!
    
    var viewModel = CharactersViewModel()
    var subscriptions = Set<AnyCancellable>()
    
    var location: Location? {
        get {
            return self.viewModel.location
        }
        set {
            self.viewModel.location = newValue
        }
    }
    
//    init(location: Location) {
//        super.init(nibName: nil, bundle: nil)
//        self.location = location
//    }
//    
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.charactersCollectionView.delegate = self
        self.charactersCollectionView.dataSource = self
        
        viewModel.$characterModels
            .receive(on: DispatchQueue.main)
            .sink { [weak self] items in
                self?.charactersCollectionView.reloadData()
            }
            .store(in: &subscriptions)
    }
}

extension CharactersViewController: UICollectionViewDelegate {
    
}

extension CharactersViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.characterModels?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CharacterCell", for: indexPath) as! CharacterCollectionViewCell
        if let characterViewModel = viewModel.characterModels?[indexPath.row] {
            cell.use(characterViewModel)
        }
        return cell
    }
}

extension CharactersViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size: CGFloat = (self.view.frame.width - 24 - 24) / 3
        return CGSize(width: size, height: size)
    }
}
