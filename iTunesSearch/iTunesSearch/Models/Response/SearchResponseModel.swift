//
//  SearchResponseModel.swift
//  iTunesSearch
//
//  Created by Enes Buğra Yenidünya on 29.05.2022.
//

import Foundation

// MARK: - SearchResponseModel
struct SearchResponseModel: Codable {
    let resultCount: Int?
    let results: [MediaItem]?
}

// MARK: - MediaItem
struct MediaItem: Codable {
    let wrapperType: String?
    let kind: String?
    let collectionName: String?
    let artworkUrl100: String?
    let collectionPrice: Double?
    let trackPrice: Double?
    let releaseDate: String?
    let currency: String?
    let trackId: Int?
    let longDescription: String?
}
