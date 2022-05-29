//
//  HomePresenter.swift
//  iTunesSearch
//
//  Created by Enes Buğra Yenidünya on 29.05.2022.
//

import Foundation

// MARK: - HomePresenterInput
protocol HomePresenterInput {
    func viewDidLoad()
}

// MARK: - HomePresenter
final class HomePresenter: HomePresenterInput {
    
    // MARK: Properties
    private let interactor: HomeInteractorInput
    
    weak var view: HomeViewDelegate?
    
    // MARK: Init
    init(interactor: HomeInteractorInput) {
        self.interactor = interactor
    }
    
    func viewDidLoad() {
        view?.setupViews()
    }
}
