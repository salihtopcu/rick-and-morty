//
//  Character.swift
//  Rick&Morty
//
//  Created by Salih Topcu on 5.02.2022.
//

import Foundation

struct Character: Decodable, Identifiable {
    
    enum Species: String, Decodable {
        case human = "Human"
        case alien = "Alien"
        case humanoid = "Humanoid"
        case unknown
        
        init(from decoder: Decoder) {
            do {
                let container = try decoder.singleValueContainer()
                if let status = try? container.decode(String.self),
                   let val = Species(rawValue: status) {
                    self = val
                } else {
                    self = .unknown
                }
            } catch {
                self = .unknown
            }
        }
    }
    
    let id: Int
    let name: String
    let status: String
    let species: Species
    let type: String
    let gender: String
    let origin: Location?
    let location: Location?
    let imageUrl: URL?
    let episodeUrls: [URL]
    let url: URL
    let created: Date
    
    enum CodingKeys: String, CodingKey {
        case id, name, status, species, type, gender, origin, location, url, created
        case imageUrl = "image"
        case episodeUrls = "episode"
    }
}
