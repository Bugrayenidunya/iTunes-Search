//
//  UIImageView+Extension.swift
//  iTunesSearch
//
//  Created by Enes Buğra Yenidünya on 29.05.2022.
//

import UIKit

extension UIImageView {
    
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    
    func downloaded(from urlStr: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: urlStr) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
