//
//  CreateAccountViewModel.swift
//  CurrencyChecker
//
//  Created by Victor Oka on 21/06/20.
//  Copyright © 2020 Victor Oka. All rights reserved.
//

import Foundation

// MARK: Create Account View Model
final class CreateAccountViewModel {
    
    private let networkingService: NetworkingService
    var userCreateViewModel: UserCreateViewModel?
    
    var isLoading: ((Bool) -> Void)?
    
    init(networkingService: NetworkingService) {
        self.networkingService = networkingService
    }
    
    func register() {
        guard let user = userCreateViewModel else { return }
        isLoading?(true)
        networkingService.register(user: user, Endpoint.build(for: Constants.Request.Dev.registerUserPath)) { [weak self] (result) in
            switch result {
            case .success(let response):
                print(response.message)
                self?.finishRegister()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func finishRegister() {
        isLoading?(false)
    }
}
