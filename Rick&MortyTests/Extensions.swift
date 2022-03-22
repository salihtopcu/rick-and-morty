//
//  Extensions.swift
//  Rick&MortyTests
//
//  Created by Salih Topcu on 20.03.2022.
//

import XCTest

extension XCTestCase {
    
    func loadStub(name: String, extension: String) -> Data {
        let bundle = Bundle(for: type(of: self))
        let url = bundle.url(forResource: name, withExtension: `extension`)
        return try! Data(contentsOf: url!)
    }
    
}
