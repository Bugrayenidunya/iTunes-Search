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
        let urlSession = URLSession.shared
        
        let networkManager = NetworkManager(session: urlSession)
        
        let searchApi = SearchAPI(networkManager: networkManager)
        
        let repository = HomeRepository(searchApi: searchApi)
        
        let interactor = HomeInteractor(repository: repository)
        
        let presenter = HomePresenter(interactor: interactor)
        
        let controller = HomeController(presenter: presenter)
        
        presenter.view = controller
        interactor.output = presenter
        repository.output = interactor
        
        return .init(rootViewController: controller)
    }
}
