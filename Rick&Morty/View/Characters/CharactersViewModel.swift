//
//  CharactersViewModel.swift
//  Rick&Morty
//
//  Created by Salih Topcu on 12.02.2022.
//

import Combine

class CharactersViewModel: RoutableViewModel {
    @Published var isLoading: Bool = false
    @Published var characterViewModels: [CharacterCellViewModel]?
    
    private var nextPageNumber: Int? = 1
    private var currentPageNumber: Int?
    private var listInfo: ApiListInfo? {
        didSet {
            if let next = listInfo?.next {
                if let val = next.queryParameters?["page"] {
                    nextPageNumber = Int(val)
                    return
                }
            }
            nextPageNumber = nil
        }
    }
    private var characters: [Character]?
    
    func start() {
        loadNextPage()
    }
    
    func loadNextPage(service: Service = RMService.shared) {
        guard let next = nextPageNumber else { return }
        self.isLoading = true
        service.filterCharacters(page: next) { [weak self] result, error in
            self?.isLoading = false
            if result != nil {
                self?.currentPageNumber = next
                self?.listInfo = result!.info
                if self?.characters == nil {
                    self?.characters = result!.results
                    self?.characterViewModels = result!.results.map({ return CharacterCellViewModel(character: $0) })
                } else {
                    self?.characters! += result!.results
                    self?.characterViewModels! += result!.results.map({ return CharacterCellViewModel(character: $0) })
                }
            } else if error != nil {
                print(error ?? "error")
            }
        }
    }
}
