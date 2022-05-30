//
//  AlertManager.swift
//  iTunesSearch
//
//  Created by Enes Buğra Yenidünya on 29.05.2022.
//

import Foundation
import UIKit

// MARK: - AlertShowable
protocol AlertShowable {
    func showAlert(with error: ApiError)
}

// MARK: - AlertManager
final class AlertManager: AlertShowable {
    
    // MARK: Properties
    static let shared: AlertManager = .init()
    
    weak var controller: UIViewController?
    
    func showAlert(with error: ApiError) {
        guard let controller = controller else { return }

        let alert = UIAlertController(
            title: "Opps!",
            message: error.localizedDescription,
            preferredStyle: .alert
        )

        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { _ in
            
        }))

        DispatchQueue.main.async {
            controller.present(alert, animated: true, completion: nil)
        }
    }
}
