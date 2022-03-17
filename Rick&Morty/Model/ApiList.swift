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
    let next: URL?
    let prev: URL?
}

struct ApiList<T: Decodable>: Decodable {
    let info: ApiListInfo
    let results: [T]
}
