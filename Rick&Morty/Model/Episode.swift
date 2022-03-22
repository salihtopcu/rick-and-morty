//
//  Episode.swift
//  Rick&Morty
//
//  Created by Salih Topcu on 6.02.2022.
//

import Foundation

struct Episode: Codable {
    let id: Int
    let name: String
    let episode: String
    let airDate: String
    let characterUrls: [String]
    let url: String
    let created: Date

    enum CodingKeys: String, CodingKey {
        case id, name, episode
        case airDate = "air_date"
        case characterUrls = "characters"
        case url, created
    }
}
