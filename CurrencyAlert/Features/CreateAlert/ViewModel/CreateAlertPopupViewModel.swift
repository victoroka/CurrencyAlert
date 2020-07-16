//
//  CreateAlertPopupViewModel.swift
//  CurrencyAlert
//
//  Created by Victor Oka on 16/07/20.
//  Copyright © 2020 Alerta Câmbio. All rights reserved.
//

import Foundation

// MARK: Create Alert Popup View Model Delegate Protocol
protocol CreateAlertPopupViewModelDelegate {
    func createAlertSuccess(message: String)
    func createAlertFailure(error: String)
}

// MARK: Create Alert Popup View Model
final class CreateAlertPopupViewModel {
    
    private let networkingService: NetworkingService
    var delegate: CreateAlertPopupViewModelDelegate?
    
    init(networkingService: NetworkingService) {
        self.networkingService = networkingService
    }
    
    func create(alert: CreateAlertViewModel) {
        networkingService.create(alert: alert, Endpoint.build(for: Constants.Request.Dev.alertListPath)) { [weak self] (result) in
            switch result {
            case .success(let response):
                self?.delegate?.createAlertSuccess(message: response.message)
            case .failure(let error):
                print(error.localizedDescription)
                self?.delegate?.createAlertFailure(error: error.message)
            }
        }
    }
}
