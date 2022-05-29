//
//  HomeWireframe.swift
//  iTunesSearch
//
//  Created by Enes Buğra Yenidünya on 29.05.2022.
//

import UIKit

// MARK: - HomeWireframeRoutable
protocol HomeWireframeRoutable {
    func navigateToDetail(with viewModel: DetailViewModel)
}

// MARK: - HomeWireframe
final class HomeWireframe: HomeWireframeRoutable {
    
    // MARK: Properties
    weak var navigationController: UINavigationController?
    
    func navigateToDetail(with viewModel: DetailViewModel) {
        guard let navigationController = navigationController else { return }
        
        let detailController = DetailBuilder.build(
            navigationController: navigationController,
            viewModel: viewModel
        )
        
        navigationController.pushViewController(detailController, animated: true)
    }
}
