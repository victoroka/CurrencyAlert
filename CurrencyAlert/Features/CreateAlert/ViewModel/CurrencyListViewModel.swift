//
//  CurrencyListViewModel.swift
//  CurrencyAlert
//
//  Created by Victor Oka on 07/07/20.
//  Copyright © 2020 Alerta Câmbio. All rights reserved.
//

import Foundation

// MARK: Currencies View Model Delegate Protocol
protocol CurrencyListViewModelDelegate {
    func fetchCurrenciesSuccess(currencies: [CurrencyViewModel])
    func fetchCurrenciesFailure()
}

// MARK: Currencies List View Model
final class CurrencyListViewModel {
    
    private let networkingService: NetworkingService
    var delegate: CurrencyListViewModelDelegate?
    
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
