//
//  Service.swift
//  Rick&Morty
//
//  Created by Salih Topcu on 11.03.2022.
//

import Foundation
import Alamofire

protocol LocationApi {
    
    func filter(page: Int, completion: Completion<ApiList<Location>, Error>?)
    
    func find(id: Int, completion: Completion<Location, Error>?)
}

protocol CharacterApi {
    
    func filter(page: Int, completion: Completion<ApiList<Character>, Error>?)
    
    func find(id: Int, completion: Completion<Character, Error>?)
}


protocol EpisodeApi {
    
    func filter(page: Int, completion: Completion<ApiList<Episode>, Error>?)
    
    func find(id: Int, completion: Completion<Episode, Error>?)
}

extension DataRequest {
    
    enum CustomError: Error {
        case unknownResult
    }
    
    static var decoder: JSONDecoder = {
        let formatter = Foundation.DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(formatter)
        return decoder
    }()
    
    @discardableResult
    fileprivate func run<T: Decodable>(
        of type: T.Type = T.self,
        completion: Completion<T, Error>?) -> Self {
            return validate(statusCode: 200..<300)
                .validate(contentType: ["application/json"])
                .responseDecodable(of: T.self, decoder: DataRequest.decoder) { response in
                    switch response.result {
                    case .success:
                        guard let value: T = response.value else {
                            completion?(nil, CustomError.unknownResult)
                            break
                        }
                        completion?(value, nil)
                        break
                    case let .failure(error):
                        print(error)
                        completion?(nil, error)
                        break
                    }
                }
        }
}

struct Service {
    static let urlRoot = "https://rickandmortyapi.com/api/"
    
    static var shared = Service(
        locations: RMLocationApi(),
        characters: RMCharacterApi(),
        episodes: RMEpisodeApi())
    
    let locations: RMLocationApi
    let characters: RMCharacterApi
    let episodes: RMEpisodeApi
    
    struct RMLocationApi: LocationApi {
        func filter(page: Int, completion: Completion<ApiList<Location>, Error>?) {
            AF.request("\(urlRoot)location", parameters: ["page": page])
                .run(of: ApiList<Location>.self, completion: completion)
        }
        
        func find(id: Int, completion: Completion<Location, Error>?) {
            AF.request("\(urlRoot)location/\(id)")
                .run(of: Location.self, completion: completion)
        }
    }
    
    struct RMCharacterApi: CharacterApi {
        func filter(page: Int, completion: Completion<ApiList<Character>, Error>?) {
            AF.request("\(urlRoot)character", parameters: ["page": page])
                .run(of: ApiList<Character>.self, completion: completion)
        }
        
        func find(id: Int, completion: Completion<Character, Error>?) {
            AF.request("\(urlRoot)character/\(id)")
                .run(of: Character.self, completion: completion)
        }
    }
    
    struct RMEpisodeApi: EpisodeApi {
        func filter(page: Int, completion: Completion<ApiList<Episode>, Error>?) {
            AF.request("\(urlRoot)episode", parameters: ["page": page])
                .run(of: ApiList<Episode>.self, completion: completion)
        }
        
        func find(id: Int, completion: Completion<Episode, Error>?) {
            AF.request("\(urlRoot)episode/\(id)")
                .run(of: Episode.self, completion: completion)
        }
    }
}
