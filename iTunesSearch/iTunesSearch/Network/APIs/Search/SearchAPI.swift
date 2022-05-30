//
//  SearchAPI.swift
//  iTunesSearch
//
//  Created by Enes Buğra Yenidünya on 29.05.2022.
//

import Foundation

// MARK: - MediaSearchable
protocol MediaSearchable {
    func search(request: SearchRequestModel, completion: @escaping (Result<SearchResponseModel, ApiError>) -> Void)
}

// MARK: - SearchAPI
final class SearchAPI: MediaSearchable {
    
    // MARK: Properties
    private let networkManager: Networking
    
    // MARK: Init
    init(networkManager: Networking) {
        self.networkManager = networkManager
    }
    
    func search(request: SearchRequestModel, completion: @escaping (Result<SearchResponseModel, ApiError>) -> Void) {
        networkManager.request(request: request, completion: completion)
    }
}
