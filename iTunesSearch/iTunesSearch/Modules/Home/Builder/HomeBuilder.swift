//
//  HomeBuilder.swift
//  iTunesSearch
//
//  Created by Enes Buğra Yenidünya on 29.05.2022.
//

import Foundation
import UIKit

final class HomeBuilder {
    static func build() -> UINavigationController {
        let wireframe = HomeWireframe()
        
        let urlSession = URLSession.shared
        
        let networkManager = NetworkManager(session: urlSession)
        
        let searchApi = SearchAPI(networkManager: networkManager)
        
        let repository = HomeRepository(searchApi: searchApi)
        
        let interactor = HomeInteractor(repository: repository)
        
        let presenter = HomePresenter(interactor: interactor, wireframe: wireframe)
        
        let controller = HomeController(presenter: presenter)
        
        let navigationController = UINavigationController(rootViewController: controller)
        
        presenter.view = controller
        interactor.output = presenter
        repository.output = interactor
        wireframe.navigationController = navigationController
        
        return navigationController
    }
}
