//
//  Decoder.swift
//  Rick&Morty
//
//  Created by Salih Topcu on 5.02.2022.
//

import Foundation

struct Decoder {
    
    private static let dateFormatter: DateFormatter = { DateFormatter() }()
    
    static func decode<T>(from object: Data, to type: T.Type, dateFormat: String? = nil) throws -> Any where T: Decodable {
        let jsonData = try JSONSerialization.data(withJSONObject: object, options: .prettyPrinted)

        let reqJSONStr = String(data: jsonData, encoding: .utf8)
        let utf8data = reqJSONStr?.data(using: .utf8)
        let jsonDecoder = JSONDecoder()

        if dateFormat != nil {
            let formatter = Decoder.dateFormatter
            formatter.dateFormat = dateFormat!
            jsonDecoder.dateDecodingStrategy = .formatted(formatter)
        }
        
        let result = try jsonDecoder.decode(type.self, from: utf8data!)
        return result
    }
}
