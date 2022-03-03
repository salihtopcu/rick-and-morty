//
//  Character.swift
//  Rick&Morty
//
//  Created by Salih Topcu on 5.02.2022.
//

import Foundation
import Alamofire

struct Character: Decodable, Identifiable {
    
    enum Species: String, Decodable {
        case human = "Human"
        case alien = "Alien"
    }
    
    let id: Int
    let name: String
    let status: String
    let species: Species
    let type: String
    let gender: String
    let origin: Location
    let location: Location
    let imageUrl: String
    let episodeUrls: [String]
    let url: String
    let created: String
    
    enum CodingKeys: String, CodingKey {
        case id, name, status, species, type, gender, origin, location, url, created
        case imageUrl = "image"
        case episodeUrls = "episode"
    }
}

// MARK: - API Call Methods


extension Character {
    
    static func filter(
        onSuccess: @escaping (ApiList<Character>) -> Void,
        onFail: @escaping (Error?) -> Void) {
        AF.request("https://rickandmortyapi.com/api/character")
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseDecodable(of: ApiList<Character>.self) { response in
                debugPrint("Response: \(response)")
                switch response.result {
                case .success:
                    guard let value = response.value else {
                        onFail(nil)
                        break
                    }
                    onSuccess(value)
                    break
                case let .failure(error):
                    print(error)
                    onFail(error)
                    break
                }
            }
    }
    
    static func find(_ id: Int) {
        AF.request("https://rickandmortyapi.com/api/character/\(id)")
            .responseDecodable(of: Character.self) { response in
                debugPrint("Response: \(response)")
            }
    }
    
    static func find2(_ id: Int) {
        AF.request("https://rickandmortyapi.com/api/character/\(id)")
            .responseData { response in
                guard let data = response.value else { return }
                do {
                    let char = try JSONDecoder().decode(Character.self, from: data)
                    debugPrint("Response: \(char)")
                } catch {
                    debugPrint(error.localizedDescription)
                }
            }
    }
}
