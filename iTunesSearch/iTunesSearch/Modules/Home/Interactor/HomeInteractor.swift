//
//  HomeInteractor.swift
//  iTunesSearch
//
//  Created by Enes Buğra Yenidünya on 29.05.2022.
//

import Foundation

// MARK: HomeInteractorInput
protocol HomeInteractorInput {
    func sessionDidBegin()
    func search(with term: String, limit: Int, mediaType: MediaType)
    func update(viewModel: HomeViewModel)
}

// MARK: - HomeInteractorOutput
protocol HomeInteractorOutput: AnyObject {
    func home(_ interactor: HomeInteractorInput, didConfigureMediaWith viewModel: HomeViewModel)
    func home(_ interactor: HomeInteractorInput, didConfigureErrorWith error: ApiError)
}

// MARK: - HomeInteractor
final class HomeInteractor: HomeInteractorInput {
    
    // MARK: Properties
    private let repository: HomeRepositoryInput
    private let alertManager: AlertShowable
    
    private var viewModel: HomeViewModel?
    
    weak var output: HomeInteractorOutput?
    
    // MARK: Init
    init(repository: HomeRepositoryInput,
         alertManager: AlertShowable) {
        self.repository = repository
        self.alertManager = alertManager
    }
    
    func sessionDidBegin() {
        repository.makeInitialFetch()
    }
    
    func search(with term: String, limit: Int, mediaType: MediaType) {
        repository.search(with: term, limit: limit, mediaType: mediaType)
    }
    
    func update(viewModel: HomeViewModel) {
        self.viewModel = viewModel
    }
}

// MARK: - HomeRepositoryOutput
extension HomeInteractor: HomeRepositoryOutput {
    func home(_ repository: HomeRepositoryInput, didFetchMediaWith response: SearchResponseModel) {
        guard let results = response.results else { return }
        
        if let viewModel = viewModel {
            self.viewModel = viewModel.update(
                selectedMediaType: viewModel.selectedMediaType,
                medias: results.compactMap({ .init(mediaItem: $0) }),
                limit: viewModel.limit,
                pageCount: viewModel.pageCount,
                maxPageCount: viewModel.maxPageCount,
                searchTerm: viewModel.searchTerm
            )
            
            output?.home(self, didConfigureMediaWith: self.viewModel!)
        } else {
            self.viewModel = HomeViewModel(
                selectedMediaType: .all,
                medias: results.compactMap({ .init(mediaItem: $0) }),
                limit: 20,
                pageCount: 1,
                maxPageCount: 10,
                searchTerm: .empty
            )
            
            output?.home(self, didConfigureMediaWith: self.viewModel!)
        }
    }
    
    func home(_ repository: HomeRepositoryInput, didFailMediaWith error: ApiError) {
        alertManager.showAlert(with: error)
    }
}
