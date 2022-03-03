//
//  LocationViewModel.swift
//  Rick&Morty
//
//  Created by Salih Topcu on 2.03.2022.
//

import Combine

class LocationViewModel {
    @Published var nameText: String
    @Published var residentsCountText: String
    @Published var iconName: String
    @Published var isIndicatorVisible: Bool
    
    var location: Location
    
    init(location: Location) {
        self.location = location
        self.nameText = location.name
        let residentsCount = location.residents?.count ?? 0
        self.residentsCountText = residentsCount > 0 ? String(residentsCount) : ""
        self.iconName = LocationViewModel.getIconName(for: location.type ?? "")
        self.isIndicatorVisible = residentsCount > 0
    }
    
    static func getIconName(for locationType: String) -> String {
        switch locationType {
            case "Planet": return "globe"
            case "Cluster": return "circles.hexagonpath.fill"
            case "Space station": return "logo.xbox"
            case "Microverse": return "homepodmini.fill"
            case "TV": return "sparkles.tv.fill"
            case "Resort": return "sleep.circle.fill"
            default: return "questionmark"
        }
    }
}
