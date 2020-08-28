//
//  LoginViewModel.swift
//  CurrencyChecker
//
//  Created by Victor Oka on 23/06/20.
//  Copyright © 2020 Victor Oka. All rights reserved.
//

import Foundation

// MARK: Login View Model Delegate Protocol
protocol LoginViewModelDelegate {
    func loginSuccess()
    func loginFailure(error: String)
}

// MARK: Login View Model
final class LoginViewModel {
    
    private let networkingService: NetworkingService
    var userLoginViewModel: UserLoginViewModel?
    var delegate: LoginViewModelDelegate?
    
    init(networkingService: NetworkingService) {
        self.networkingService = networkingService
    }
    
    func login() {
        guard let user = userLoginViewModel else { return }
        networkingService.login(user: user, Endpoint.build(for: Constants.Request.Dev.loginPath)) { [weak self] (result) in
            guard let loginDelegate = self?.delegate else { return }
            switch result {
            case .success(let response):
                guard let userInformation = response.user else { return }
                print(response.message)
                DispatchQueue.main.async {
                    self?.setupAuthorization(for: user)
                    self?.setupUserSessionInformation(for: userInformation)
                    loginDelegate.loginSuccess()
                }
            case .failure(let error):
                print(error.message)
                DispatchQueue.main.async {
                    loginDelegate.loginFailure(error: error.message)
                }
            }
        }
    }
    
    private func setupAuthorization(for user: UserLoginViewModel) {
        let auth = "\(user.email):\(user.password)"
        UserDefaults.standard.set(auth.toBase64(), forKey: Constants.AUTH_KEY)
        UserDefaults.standard.synchronize()
    }
    
    private func setupUserSessionInformation(for userInfo: User) {
        UserDefaults.standard.set(userInfo.email, forKey: Constants.EMAIL_KEY)
        UserDefaults.standard.set(userInfo.firstName, forKey: Constants.FIRST_NAME_KEY)
        UserDefaults.standard.set(userInfo.lastName, forKey: Constants.LAST_NAME_KEY)
        UserDefaults.standard.set(userInfo.phone, forKey: Constants.PHONE_KEY)
        UserDefaults.standard.synchronize()
    }
}
