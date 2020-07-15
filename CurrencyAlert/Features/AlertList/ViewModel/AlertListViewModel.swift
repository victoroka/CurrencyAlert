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
    func fetchAlertsSuccess(alerts: [AlertViewModel])
    func fetchAlertsFailure()
}

// MARK: Alert List View Model
final class AlertListViewModel {
    
    private let networkingService: NetworkingService
    var delegate: AlertListViewModelDelegate?
    
    init(networkingService: NetworkingService) {
        self.networkingService = networkingService
    }
    
    func fetch() {
        networkingService.fetchAlerts(Endpoint.build(for: Constants.Request.Dev.alertListPath)) { [weak self] (result) in
            switch result {
            case .success(let fetchedAlerts):
                let alerts = fetchedAlerts.map { AlertViewModel(alert: $0) }
                self?.delegate?.fetchAlertsSuccess(alerts: alerts)
            case .failure(let error):
                print(error.localizedDescription)
                self?.delegate?.fetchAlertsFailure()
            }
        }
    }
}
