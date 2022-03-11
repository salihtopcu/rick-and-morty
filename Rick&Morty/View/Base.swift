//
//  ViewModel.swift
//  Rick&Morty
//
//  Created by Salih Topcu on 8.03.2022.
//

import UIKit

protocol RoutableViewModel {
    func start()
}

class Router<T: RoutableViewModel> {
    let context: UIViewController
    let viewModel: T
    
    init(from context: UIViewController, viewModel: T) {
        self.context = context
        self.viewModel = viewModel
    }
}

class RoutableViewController<T: RoutableViewModel>: UIViewController {
    var viewModel: T!
}

class RouterViewController<T1: RoutableViewModel, T2: Router<T1>>: RoutableViewController<T1> {
    var router: T2?
}
