//
//  HomeRepository.swift
//  iTunesSearch
//
//  Created by Enes Buğra Yenidünya on 29.05.2022.
//

import Foundation

// MARK: - HomeRepositoryInput
protocol HomeRepositoryInput {
    func makeInitialFetch()
    func search(with term: String, limit: Int, mediaType: MediaType)
}

// MARK: - HomeRepositoryOutput
protocol HomeRepositoryOutput: AnyObject {
    func home(_ repository: HomeRepositoryInput, didFetchMediaWith response: SearchResponseModel)
    func home(_ repository: HomeRepositoryInput, didFailMediaWith error: ApiError)
}

// MARK: - HomeRepository
final class HomeRepository: HomeRepositoryInput {
    
    // MARK: Peroperties
    private let searchApi: MediaSearchable
    
    weak var output: HomeRepositoryOutput?
    
    init(searchApi: MediaSearchable) {
        self.searchApi = searchApi
    }
    
    func makeInitialFetch() {
        let request = SearchRequestModel(searchTerm: "Pink Floyd", limit: String(10), mediaType: .all)
        
        searchApi.search(request: request) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .failure(let error):
                self.output?.home(self, didFailMediaWith: error)
                
            case .success(let response):
                self.output?.home(self, didFetchMediaWith: response)
            }
        }
    }
    
    func search(with term: String, limit: Int, mediaType: MediaType) {
        let request = SearchRequestModel(searchTerm: term, limit: String(limit), mediaType: mediaType)
        
        searchApi.search(request: request) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .failure(let error):
                self.output?.home(self, didFailMediaWith: error)
                
            case .success(let response):
                self.output?.home(self, didFetchMediaWith: response)
            }
        }
    }
}
