//
//  DetailBuilder.swift
//  iTunesSearch
//
//  Created by Enes Buğra Yenidünya on 29.05.2022.
//

import UIKit

final class DetailBuilder {
    static func build(navigationController: UINavigationController,
                      viewModel: DetailViewModel) -> UIViewController {
        
        let wireframe = DetailWireframe()
        
        let repository = DetailRepository()
        
        let interactor = DetailInteractor(repository: repository)
        
        let presenter = DetailPresenter(interactor: interactor, wireframe: wireframe)
        
        let controller = DetailController(presenter: presenter)
        controller.configure(with: viewModel)
        
        presenter.view = controller
        interactor.output = presenter
        repository.output = interactor
        wireframe.navigationController = navigationController
        
        return controller
    }
}
