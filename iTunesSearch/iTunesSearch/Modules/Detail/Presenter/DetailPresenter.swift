//
//  DetailPresenter.swift
//  iTunesSearch
//
//  Created by Enes Buğra Yenidünya on 29.05.2022.
//

import Foundation

// MARK: - DetailPresenterInput
protocol DetailPresenterInput {
    func viewDidLoad()
}

// MARK: - DetailPresenter
final class DetailPresenter: DetailPresenterInput {
    
    // MARK: Properties
    private let interactor: DetailInteractorInput
    private let wireframe: DetailWireframeRoutable
    
    weak var view: DetailViewDelegate?
    
    // MARK: Init
    init(interactor: DetailInteractorInput,
         wireframe: DetailWireframeRoutable) {
        self.interactor = interactor
        self.wireframe = wireframe
    }
    
    func viewDidLoad() {
        view?.setupViews()
    }
}

// MARK: - HomeInteractorOutput
extension DetailPresenter: DetailInteractorOutput {
    
}
