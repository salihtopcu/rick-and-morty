//
//  LocationViewModel.swift
//  Rick&Morty
//
//  Created by Salih Topcu on 2.03.2022.
//

import Combine

class LocationCellViewModel {
    var nameText: String = ""
    var residentsCountText: String = ""
    var iconName: String = ""
    var isIndicatorVisible: Bool = false
    
    let location: Location
    
    init(location: Location) {
        self.location = location
        self.nameText = location.name
        let residentsCount = location.residents?.count ?? 0
        self.residentsCountText = residentsCount > 0 ? String(residentsCount) : ""
        self.iconName = LocationCellViewModel.getIconName(for: location.type)
        self.isIndicatorVisible = residentsCount > 0
    }
    
    private static func getIconName(for locationType: Location.LocationType?) -> String {
        switch locationType {
        case .planet: return "globe"
        case .cluster: return "circles.hexagonpath.fill"
        case .spaceStation: return "logo.xbox"
        case .microverse: return "homepodmini.fill"
        case .tv: return "sparkles.tv.fill"
        case .resort: return "sleep.circle.fill"
        default: return "questionmark"
        }
    }
}
