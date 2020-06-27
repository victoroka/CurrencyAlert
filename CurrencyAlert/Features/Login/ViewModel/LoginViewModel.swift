//
//  LoginViewModel.swift
//  CurrencyChecker
//
//  Created by Victor Oka on 23/06/20.
//  Copyright © 2020 Victor Oka. All rights reserved.
//

import Foundation

protocol LoginViewModelDelegate {
    func loginSuccess()
    func loginFailure()
}

// MARK: Login View Model
final class LoginViewModel {
    
    private let networkingService: NetworkingService
    var delegate: LoginViewModelDelegate?
    var userLoginViewModel: UserLoginViewModel?
    
    var isLoading: ((Bool) -> Void)?
    
    init(networkingService: NetworkingService) {
        self.networkingService = networkingService
    }
    
    func login() {
        guard let user = userLoginViewModel else { return }
        networkingService.login(user: user, Endpoint.build(for: Constants.Request.Dev.loginPath)) { [weak self] (result) in
            guard let loginDelegate = self?.delegate else { return }
            switch result {
            case .success(let response):
                print(response.message)
                DispatchQueue.main.async {
                    self?.setupAuthorization(for: user)
                    loginDelegate.loginSuccess()
                }
            case .failure(let error):
                print(error.localizedDescription)
                DispatchQueue.main.async {
                    loginDelegate.loginFailure()
                }
            }
        }
    }
    
    private func setupAuthorization(for user: UserLoginViewModel) {
        let auth = "\(user.email):\(user.password)"
        UserDefaults.standard.set(auth.toBase64(), forKey: Constants.AUTH_KEY)
        UserDefaults.standard.synchronize()
    }
}
