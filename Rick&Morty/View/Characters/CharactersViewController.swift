//
//  CharactersViewController.swift
//  Rick&Morty
//
//  Created by Salih Topcu on 10.02.2022.
//

import UIKit
import Combine



class CharactersViewController: RouterViewController<CharactersViewModel, CharactersRouter> {
    
    enum Route: String {
        case Character
    }

    @IBOutlet weak var charactersCollectionView: UICollectionView!
    
    var subscriptions = Set<AnyCancellable>()
    
    var location: Location? {
        get {
            return self.viewModel.location
        }
        set {
            self.viewModel.location = newValue
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TODO: viewModel and router should be set by router
        if viewModel == nil {
            viewModel = CharactersViewModel()
        }
        if router == nil {
            router = CharactersRouter(from: self, viewModel: viewModel)
        }

        self.charactersCollectionView.delegate = self
        self.charactersCollectionView.dataSource = self
        
        viewModel.$characterModels
            .receive(on: DispatchQueue.main)
            .sink { [weak self] items in
                self?.charactersCollectionView.reloadData()
            }
            .store(in: &subscriptions)
        
        viewModel.start()
    }
}

extension CharactersViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let characterId = viewModel.characterModels?[indexPath.row].characterId {
            let vc = UIStoryboard(name: "Main", bundle: nil)
                .instantiateViewController(withIdentifier: "CharacterViewController") as! CharacterViewController
            vc.viewModel = CharacterViewModel(characterId: characterId)
            showDetailViewController(vc, sender: self)
        }
    }
}

extension CharactersViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.characterModels?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CharacterCell", for: indexPath) as! CharacterCell
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
