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
    func search(with term: String)
    func change(mediaType: MediaType)
}

// MARK: - HomePresenter
final class HomePresenter: HomePresenterInput {
    
    // MARK: Properties
    private let interactor: HomeInteractorInput
    private var viewModel: HomeViewModel?
    
    weak var view: HomeViewDelegate?
    
    private var newLimit: Int = .zero
    
    // MARK: Init
    init(interactor: HomeInteractorInput) {
        self.interactor = interactor
    }
    
    func viewDidLoad() {
        view?.setupViews()
        interactor.sessionDidBegin()
    }
    
    func search(with term: String) {
        guard
            let viewModel = viewModel?.update(searchTerm: term),
            viewModel.pageCount <= viewModel.maxPageCount
        else {
            return
        }

        self.viewModel = viewModel
        updateNewLimit()
        interactor.search(with: term, limit: newLimit, mediaType: viewModel.selectedMediaType)
    }
    
    func change(mediaType: MediaType) {
        guard
            let viewModel = viewModel?.update(selectedMediaType: mediaType, pageCount: 1),
            viewModel.pageCount <= viewModel.maxPageCount
        else {
            return
        }
        
        self.viewModel = viewModel
        interactor.update(viewModel: self.viewModel!)
        interactor.search(with: viewModel.searchTerm, limit: viewModel.limit, mediaType: viewModel.selectedMediaType)
    }
}

// MARK: - Helpers
private extension HomePresenter {
    func update(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        view?.update(with: viewModel)
    }
    
    func updateNewLimit() {
        guard let viewModel = viewModel else { return }
        
        if viewModel.pageCount <= viewModel.maxPageCount {
            self.newLimit = viewModel.limit * viewModel.pageCount
        } else {
            self.newLimit = 200
        }
        
        self.viewModel = viewModel.update(pageCount: viewModel.pageCount + 1)
        interactor.update(viewModel: self.viewModel!)
    }
}

// MARK: - HomeInteractorOutput
extension HomePresenter: HomeInteractorOutput {
    func home(_ interactor: HomeInteractorInput, didConfigureMediaWith viewModel: HomeViewModel) {
        update(viewModel: viewModel)
    }
}
