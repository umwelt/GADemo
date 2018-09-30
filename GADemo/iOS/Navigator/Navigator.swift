//
//  Navigator.swift
//  GADemo
//
//  Created by BMGH SRL on 29/09/2018.
//  Copyright © 2018 BMAGH. All rights reserved.
//

import UIKit

protocol Navigator {
    associatedtype Destination
    
    func navigate(to destination: Destination)
}

class GANavigator: Navigator {
    
    enum Destination {
        case movieDetail(movie: Movie)
    }
    
    private weak var navigationController: UINavigationController?
    
    // MARK: - Initializer
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Navigator
    func navigate(to destination: GANavigator.Destination) {
        let viewController = viewControllerFactory(for: destination)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    // MARK: - Private
    private func viewControllerFactory(for destination: Destination) -> UIViewController {
        switch destination {
        case .movieDetail(let movie):
            return MovieDetailViewController(movie: movie)
        }
    }
    
}

