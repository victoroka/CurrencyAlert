//
//  CurrenciesListViewModel.swift
//  CurrencyChecker
//
//  Created by Victor Oka on 16/06/20.
//  Copyright © 2020 Victor Oka. All rights reserved.
//

import Foundation

// MARK: Alert List View Model Delegate Protocol
protocol AlertListViewModelDelegate {
    func fetchCurrenciesSuccess(currencies: [CurrencyViewModel])
    func fetchCurrenciesFailure()
}

// MARK: Alert List View Model
final class AlertListViewModel {
    
    private let networkingService: NetworkingService
    var delegate: AlertListViewModelDelegate?
    
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
