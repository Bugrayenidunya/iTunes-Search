//
//  DetailViewModel.swift
//  iTunesSearch
//
//  Created by Enes Buğra Yenidünya on 29.05.2022.
//

import Foundation

struct DetailViewModel {
    let imageUrl: URL?
    let name: String
    let price: String
    let releaseDate: String
    let description: String
    
    init(viewModel: HomeCollectionViewCellViewModel) {
        imageUrl = viewModel.artworkUrl
        name = viewModel.collectionName
        price = viewModel.collectionPrice
        releaseDate = viewModel.releaseDate
        description = viewModel.description
    }
}
