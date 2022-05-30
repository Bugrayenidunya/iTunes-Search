//
//  DetailWireframe.swift
//  iTunesSearch
//
//  Created by Enes Buğra Yenidünya on 29.05.2022.
//

import Foundation
import UIKit

// MARK: - DetailWireframeRoutable
protocol DetailWireframeRoutable {
    
}

// MARK: - DetailWireframe
final class DetailWireframe: DetailWireframeRoutable {
    
    // MARK: Properties
    weak var navigationController: UINavigationController?
}
