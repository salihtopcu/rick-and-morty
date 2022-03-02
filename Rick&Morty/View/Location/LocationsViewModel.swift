//
//  LocationsViewModel.swift
//  Rick&Morty
//
//  Created by Salih Topcu on 12.02.2022.
//

import Combine

class LocationsViewModel {
    @Published var isLoading: Bool = false
    @Published var locationModels: [LocationViewModel]?
    var hasNextPage: Bool = false
    
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
    
    private var listInfo: ApiListInfo?
    private var locations: [Location]?
        
    init() {
        self.currentPage = 1
    }
    
    func loadLocations() {
        self.isLoading = true
        Location.filter(onSuccess: { [weak self] result in
            self?.isLoading = false
            self?.listInfo = result.info
            self?.locations = result.results
            self?.hasNextPage = result.info.next != nil
            self?.locationModels = [LocationViewModel]()
            for item in result.results {
                self?.locationModels!.append(LocationViewModel(location: item))
            }
        }, onFail: { error in
            self.isLoading = false
            print(error ?? "error")
        })
    }
}
