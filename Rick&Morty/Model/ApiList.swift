//
//  ListInfo.swift
//  Rick&Morty
//
//  Created by Salih Topcu on 7.02.2022.
//

import Foundation

struct ApiListInfo: Decodable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}

struct ApiList<T: Decodable>: Decodable {
    let info: ApiListInfo
    let results: [T]
}
