//
//  HomeViewModel.swift
//  iTunesSearch
//
//  Created by Enes Buğra Yenidünya on 29.05.2022.
//

import Foundation

struct HomeViewModel {
    let medias: [HomeCollectionViewCellViewModel]
    
    init(medias: [MediaItem]) {
        self.medias = medias.compactMap({ HomeCollectionViewCellViewModel(mediaItem: $0) })
    }
}
