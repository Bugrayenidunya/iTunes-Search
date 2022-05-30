//
//  HomeViewModel.swift
//  iTunesSearch
//
//  Created by Enes Buğra Yenidünya on 29.05.2022.
//

import Foundation

struct HomeViewModel {
    let searchTerm: String
    let selectedMediaType: MediaType
    let medias: [HomeCollectionViewCellViewModel]
    let limit: Int
    let pageCount: Int
    let maxPageCount: Int
    
    init(selectedMediaType: MediaType, medias: [MediaItem], limit: Int, pageCount: Int, maxPageCount: Int, searchTerm: String) {
        self.medias = medias.compactMap({ HomeCollectionViewCellViewModel(mediaItem: $0) })
        self.selectedMediaType = selectedMediaType
        self.limit = limit
        self.pageCount = pageCount
        self.maxPageCount = maxPageCount
        self.searchTerm = searchTerm
    }
}

// MARK: - Helpers
extension HomeViewModel {
    init(
        selectedMediaType: MediaType,
        medias: [HomeCollectionViewCellViewModel],
        limit: Int,
        pageCount: Int,
        maxPageCount: Int,
        searchTerm: String
    ) {
        self.selectedMediaType = selectedMediaType
        self.medias = medias
        self.limit = limit
        self.pageCount = pageCount
        self.maxPageCount = maxPageCount
        self.searchTerm = searchTerm
    }
    
    func update(
        selectedMediaType: MediaType? = nil,
        medias: [HomeCollectionViewCellViewModel]? = nil,
        limit: Int? = nil,
        pageCount: Int? = nil,
        maxPageCount: Int? = nil,
        searchTerm: String? = nil
    ) -> Self {
        Self(selectedMediaType: selectedMediaType ?? self.selectedMediaType,
             medias: medias ?? self.medias,
             limit: limit ?? self.limit,
             pageCount: pageCount ?? self.pageCount,
             maxPageCount: maxPageCount ?? self.maxPageCount,
             searchTerm: searchTerm ?? self.searchTerm
        )
    }
}
