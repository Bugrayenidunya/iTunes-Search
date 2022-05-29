//
//  DetailRepository.swift
//  iTunesSearch
//
//  Created by Enes Buğra Yenidünya on 29.05.2022.
//

import Foundation

// MARK: - DetailRepositoryInput
protocol DetailRepositoryInput {
    
}

// MARK: - DetailRepositoryOutput
protocol DetailRepositoryOutput: AnyObject {
    
}

// MARK: - DetailRepository
final class DetailRepository: DetailRepositoryInput {
    
    // MARK: Properties
    weak var output: DetailRepositoryOutput?
}
