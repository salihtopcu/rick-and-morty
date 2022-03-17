//
//  Location.swift
//  Rick&Morty
//
//  Created by Salih Topcu on 5.02.2022.
//

import Foundation
import Alamofire

struct Location: Codable {
    
    enum LocationType: String, Codable {
        case planet = "Planet",
             cluster = "Cluster",
             spaceStation = "Space station",
             microverse = "Microverse",
             tv = "TV",
             resort = "Resort",
             fantasyTown = "Fantasy town",
             dream = "Dream",
             dimenstion = "Dimension",
             unknown
        
        init(from decoder: Decoder) {
            do {
                let container = try decoder.singleValueContainer()
                if let status = try? container.decode(String.self),
                   let val = LocationType(rawValue: status) {
                    self = val
                } else {
                    self = .unknown
                }
            } catch {
                self = .unknown
            }
        }
    }
    
    let id: Int?
    let name: String
    let type: LocationType?
    let dimension: String?
    let residents: [URL]?
    let urlString: String
    let created: String?
    
    lazy var url: URL? = {
        if let result = URL(string: self.urlString) {
            return result
        }
        return nil
    }()
    
    enum CodingKeys: String, CodingKey {
        case id, name, type, dimension, residents, urlString = "url", created
    }
    
//    init(data: Data, jsonDecoder: JSONDecoder) throws {
//        self = try jsonDecoder.decode(Location.self, from: data)
//    }
}

//func newJSONDecoder() -> JSONDecoder {
//    let decoder = JSONDecoder()
//    decoder.dateDecodingStrategy = .iso8601
//    return decoder
//}
