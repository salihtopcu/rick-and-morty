//
//  LocationsViewModel.swift
//  Rick&Morty
//
//  Created by Salih Topcu on 12.02.2022.
//

import Combine
import Foundation

class LocationsViewModel: RoutableViewModel {
    @Published var isLoading: Bool = false
    @Published var locationViewModels: [LocationCellViewModel]?
    
    private let api: LocationApi
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
    private var locations: [Location]?
    
    init(api: LocationApi) {
        self.api = api
    }
    
    func start() {
        loadNextPage()
    }
    
    func loadNextPage() {
        guard let next = nextPageNumber else { return }
        self.isLoading = true
        api.filter(page: next) { [weak self] result, error in
            self?.isLoading = false
            if result != nil {
                self?.currentPageNumber = next
                self?.listInfo = result!.info
                if self?.locations == nil {
                    self?.locations = result!.results
                    self?.locationViewModels = result!.results.map({ return LocationCellViewModel(location: $0) })
                } else {
                    self?.locations! += result!.results
                    self?.locationViewModels! += result!.results.map({ return LocationCellViewModel(location: $0) })
                }
            } else if error != nil {
                print(error ?? "error")
            }
        }
    }
}
