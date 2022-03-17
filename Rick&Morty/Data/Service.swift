//
//  Service.swift
//  Rick&Morty
//
//  Created by Salih Topcu on 11.03.2022.
//

import Foundation

protocol Service {
    
    func filterLocations(page: Int, completion: Completion<ApiList<Location>, Error>?)
    
    func findLocation(id: Int, completion: Completion<Location, Error>?)
    
    func filterCharacters(page: Int, completion: Completion<ApiList<Character>, Error>?)
    
    func findCharacter(id: Int, completion: Completion<Character, Error>?)
    
    func filterEpisodes(page: Int, completion: Completion<ApiList<Episode>, Error>?)
    
    func findEpisode(id: Int, completion: Completion<Episode, Error>?)
}

import Alamofire

extension DataRequest {
    
    enum CustomError: Error {
        case unknownResult
    }
    
    @discardableResult
    fileprivate func run<T: Decodable>(
        of type: T.Type = T.self,
        completion: Completion<T, Error>?) -> Self {
            return validate(statusCode: 200..<300)
                .validate(contentType: ["application/json"])
                .responseDecodable(of: T.self) { response in
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

struct RMService: Service {
    private let urlRoot = "https://rickandmortyapi.com/api/"
    
    static var shared = RMService()
    
    func filterLocations(page: Int, completion: Completion<ApiList<Location>, Error>?) {
        AF.request("\(urlRoot)location", parameters: ["page": page])
            .run(of: ApiList<Location>.self, completion: completion)
    }
    
    func findLocation(id: Int, completion: Completion<Location, Error>?) {
        AF.request("\(urlRoot)location/\(id)")
            .run(of: Location.self, completion: completion)
    }
    
    func filterCharacters(page: Int, completion: Completion<ApiList<Character>, Error>?) {
        AF.request("\(urlRoot)character", parameters: ["page": page])
            .run(of: ApiList<Character>.self, completion: completion)
    }
    
    func findCharacter(id: Int, completion: Completion<Character, Error>?) {
        AF.request("\(urlRoot)character/\(id)")
            .run(of: Character.self, completion: completion)
    }
    
    func filterEpisodes(page: Int, completion: Completion<ApiList<Episode>, Error>?) {
        AF.request("\(urlRoot)episode", parameters: ["page": page])
            .run(of: ApiList<Episode>.self, completion: completion)
    }
    
    func findEpisode(id: Int, completion: Completion<Episode, Error>?) {
        AF.request("\(urlRoot)episode/\(id)")
            .run(of: Episode.self, completion: completion)
    }
}
