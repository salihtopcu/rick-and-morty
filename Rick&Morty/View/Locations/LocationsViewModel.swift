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
    var nextPageNumber: Int?
    
    private var _currentPage: Int?
    var currentPage: Int? {
        get {
            return self._currentPage
        }
        set {
            self._currentPage = newValue
            self.loadLocations()
        }
    }
    
    private var listInfo: ApiListInfo? {
        didSet {
            if let next = listInfo?.next {
                if let val = URL(string: next)?.queryParameters?["page"] {
                    nextPageNumber = Int(val)
                    return
                }
            }
            nextPageNumber = nil
        }
    }
    var locations: [Location]? {
        didSet {
            locationViewModels = locations?.map({ return LocationCellViewModel(location: $0) }) ?? []
        }
    }
    
    func start() {
        self.currentPage = 1
    }
    
    private func loadLocations() {
        self.isLoading = true
        Location.filter(onSuccess: { [weak self] result in
            self?.isLoading = false
            self?.listInfo = result.info
            self?.locations = result.results
        }, onFail: { error in
            self.isLoading = false
            print(error ?? "error")
        })
    }
}
