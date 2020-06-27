//
//  CurrenciesListViewModel.swift
//  CurrencyChecker
//
//  Created by Victor Oka on 16/06/20.
//  Copyright © 2020 Victor Oka. All rights reserved.
//

import Foundation

// MARK: Currencies List View Model
final class CurrenciesListViewModel {
    
    private let networkingService: NetworkingService
    private var currentSearchNetworkTask: URLSessionDataTask?
    
    var isRefreshing: ((Bool) -> Void)?
    var didUpdateCurrencies: (([CurrencyViewModel]) -> Void)?
    var didSelectCurrency: ((Int) -> Void)?
    
    private(set) var currencies: [Currency] = [Currency]() {
        didSet {
            didUpdateCurrencies?(currencies.map { CurrencyViewModel(currency: $0) })
        }
    }
    
    init(networkingService: NetworkingService) {
        self.networkingService = networkingService
    }
    
    func ready() {
        isRefreshing?(true)
        networkingService.fetchCurrencies(Endpoint.build(for: Constants.Request.Dev.currenciesListPath)) { [weak self] (result) in
            switch result {
            case .success(let fetchedCurrencies):
                self?.finishFetching(with: fetchedCurrencies)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func finishFetching(with currencies: [Currency]) {
        isRefreshing?(false)
        self.currencies = currencies
    }
}
