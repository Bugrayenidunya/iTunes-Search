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
}

// MARK: - HomeInteractorOutput
protocol HomeInteractorOutput: AnyObject {
    func home(_ interactor: HomeInteractorInput, didConfigureMediaWith viewModel: HomeViewModel)
    // func home(_ interactor: HomeInteractorInput, didConfigureErrorWith )
}

// MARK: - HomeInteractor
final class HomeInteractor: HomeInteractorInput {
    
    // MARK: Properties
    private let repository: HomeRepositoryInput
    
    weak var output: HomeInteractorOutput?
    
    init(repository: HomeRepositoryInput) {
        self.repository = repository
    }
    
    func sessionDidBegin() {
        repository.makeInitialFetch()
    }
}

// MARK: - HomeRepositoryOutput
extension HomeInteractor: HomeRepositoryOutput {
    func home(_ repository: HomeRepositoryInput, didFetchMediaWith response: SearchResponseModel) {
        guard let results = response.results else { return }
        
        let viewModel = HomeViewModel(
            medias: results.compactMap({ $0 })
        )
        
        output?.home(self, didConfigureMediaWith: viewModel)
    }
    
    func home(_ repository: HomeRepositoryInput, didFailMediaWith error: ApiError) {
        
    }
}
