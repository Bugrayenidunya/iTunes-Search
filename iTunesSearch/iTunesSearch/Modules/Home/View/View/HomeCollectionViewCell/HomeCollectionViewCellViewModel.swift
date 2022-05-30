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
    let description: String
    
    init(mediaItem: MediaItem) {
        id = UUID()
        artworkUrl = URL(string: mediaItem.artworkUrl100 ?? .empty)
        collectionPrice = "\(mediaItem.currency ?? .empty) \(mediaItem.collectionPrice ?? .zero)"
        collectionName = mediaItem.collectionName ?? .empty
        releaseDate = mediaItem.releaseDate?.formatIsoStringToReadableDate() ?? .empty
        description = mediaItem.longDescription ?? .empty
    }
}
