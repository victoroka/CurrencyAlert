//
//  CurrenciesListViewModel.swift
//  CurrencyChecker
//
//  Created by Victor Oka on 16/06/20.
//  Copyright © 2020 Victor Oka. All rights reserved.
//

import Foundation

// MARK: Currencies View Model Delegate Protocol
protocol CurrenciesListViewModelDelegate {
    func fetchCurrenciesSuccess(currencies: [CurrencyViewModel])
    func fetchCurrenciesFailure()
}

// MARK: Currencies List View Model
final class CurrenciesListViewModel {
    
    private let networkingService: NetworkingService
    var delegate: CurrenciesListViewModelDelegate?
    
    init(networkingService: NetworkingService) {
        self.networkingService = networkingService
    }
    
    func fetch() {
        networkingService.fetchCurrencies(Endpoint.build(for: Constants.Request.Dev.currenciesListPath)) { [weak self] (result) in
            switch result {
            case .success(let fetchedCurrencies):
                let currencies = fetchedCurrencies.map { CurrencyViewModel(currency: $0) }
                self?.delegate?.fetchCurrenciesSuccess(currencies: currencies)
            case .failure(let error):
                print(error.localizedDescription)
                self?.delegate?.fetchCurrenciesFailure()
            }
        }
    }
}
