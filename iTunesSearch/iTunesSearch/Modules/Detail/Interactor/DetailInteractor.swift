//
//  DetailInteractor.swift
//  iTunesSearch
//
//  Created by Enes Buğra Yenidünya on 29.05.2022.
//

import Foundation

// MARK: - DetailInteractorInput
protocol DetailInteractorInput {
    
}

// MARK: - DetailInteractorOutput
protocol DetailInteractorOutput: AnyObject {
    
}

// MARK: - DetailInteractor
final class DetailInteractor: DetailInteractorInput {
    
    // MARK: Properties
    private let repository: DetailRepositoryInput
    
    weak var output: DetailInteractorOutput?
    
    // MARK: Init
    init(repository: DetailRepositoryInput) {
        self.repository = repository
    }
}

// MARK: - DetailRepositoryOutput
extension DetailInteractor: DetailRepositoryOutput {
    
}
