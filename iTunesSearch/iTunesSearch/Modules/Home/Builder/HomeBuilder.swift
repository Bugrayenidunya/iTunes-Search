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
        let interactor = HomeInteractor()
        
        let presenter = HomePresenter(interactor: interactor)
        
        let controller = HomeController(presenter: presenter)
        
        presenter.view = controller
        
        return .init(rootViewController: controller)
    }
}
