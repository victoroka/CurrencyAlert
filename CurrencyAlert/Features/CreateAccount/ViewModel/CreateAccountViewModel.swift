//
//  CreateAccountViewModel.swift
//  CurrencyChecker
//
//  Created by Victor Oka on 21/06/20.
//  Copyright © 2020 Victor Oka. All rights reserved.
//

import Foundation

// MARK: Create Account View Model Protocol
protocol CreateAccountViewModelDelegate {
    func registerSuccess()
    func registerFailure()
}

// MARK: Create Account View Model
final class CreateAccountViewModel {
    
    private let networkingService: NetworkingService
    var userCreateViewModel: UserCreateViewModel?
    var delegate: CreateAccountViewModelDelegate?
    
    init(networkingService: NetworkingService) {
        self.networkingService = networkingService
    }
    
    func register() {
        guard let user = userCreateViewModel else { return }
        guard let registerDelegate = self.delegate else { return }
        networkingService.register(user: user, Endpoint.build(for: Constants.Request.Dev.registerUserPath)) { [weak self] (result) in
            switch result {
            case .success(let response):
                print(response.message)
                DispatchQueue.main.async {
                    registerDelegate.registerSuccess()
                }
            case .failure(let error):
                print(error.localizedDescription)
                DispatchQueue.main.async {
                    registerDelegate.registerFailure()
                }
            }
        }
    }
}
