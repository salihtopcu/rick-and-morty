//
//  Observable.swift
//  Rick&Morty
//
//  Created by Salih Topcu on 21.02.2022.
//

class Observable<T> {
    
    private var listener: ((T?) -> Void)?
    
    var value: T? {
        didSet {
            self.listener?(value)
        }
    }
    
    init(_ value: T?) {
        self.value = value
    }
    
    func bind(_ listener: @escaping (T?) -> Void) {
        self.listener = listener
        self.listener?(self.value)
    }
}
