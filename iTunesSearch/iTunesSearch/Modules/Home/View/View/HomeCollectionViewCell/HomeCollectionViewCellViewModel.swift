//
//  HomeCollectionViewCellViewModel.swift
//  iTunesSearch
//
//  Created by Enes Buğra Yenidünya on 29.05.2022.
//

import Foundation

struct HomeCollectionViewCellViewModel: Hashable {
    let id: UUID
    let artworkUrl: URL?
    let collectionPrice: String
    let collectionName: String
    let releaseDate: String
    
    init(mediaItem: MediaItem) {
        self.id = UUID()
        self.artworkUrl = URL(string: mediaItem.artworkUrl100 ?? .empty)
        self.collectionPrice = "\(mediaItem.currency ?? .empty) \(mediaItem.collectionPrice ?? .zero)"
        self.collectionName = mediaItem.collectionName ?? .empty
        self.releaseDate = mediaItem.releaseDate?.formatIsoStringToReadableDate() ?? .empty
    }
}
