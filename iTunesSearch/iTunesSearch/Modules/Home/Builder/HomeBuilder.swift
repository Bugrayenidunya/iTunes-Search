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
        .init(rootViewController: HomeController())
    }
}
