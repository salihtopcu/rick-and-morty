//
//  Location.swift
//  Rick&Morty
//
//  Created by Salih Topcu on 5.02.2022.
//

import Foundation
import Alamofire

struct Location: Codable {
    let id: Int?
    let name: String
    let type: String?
    let dimension: String?
    let residents: [String]?
    let url: String
    let created: String?
    
//    init(data: Data, jsonDecoder: JSONDecoder) throws {
//        self = try jsonDecoder.decode(Location.self, from: data)
//    }
}

//func newJSONDecoder() -> JSONDecoder {
//    let decoder = JSONDecoder()
//    decoder.dateDecodingStrategy = .iso8601
//    return decoder
//}

extension Location {
    
    static func filter(
        onSuccess: @escaping (ApiList<Location>) -> Void,
        onFail: @escaping (Error?) -> Void) {
        AF.request("https://rickandmortyapi.com/api/location")
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseDecodable(of: ApiList<Location>.self) { response in
//                debugPrint("Response: \(response)")
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
        AF.request("https://rickandmortyapi.com/api/location/\(id)")
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseDecodable(of: Location.self) { response in
                debugPrint("Response: \(response)")
            }
    }
}

