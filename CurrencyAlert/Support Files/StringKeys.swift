//
//  StringKeys.swift
//  CurrencyAlert
//
//  Created by Victor Oka on 04/12/20.
//  Copyright © 2020 Alerta Câmbio. All rights reserved.
//

import Foundation

enum StringKeys: String {
    
    // MARK: - Login
    case loginWelcome, loginInputCredentials,
         loginEmail, loginPassword,
         loginSignIn, loginSignUp,
         loginDontHaveAnAccount, loginOk
    
    // MARK: - Create Account
    case createAccountSignUpTitle,
         createAccountFirstName, createAccountLastName,
         createAccountEmail,
         createAccountPassword, createAccountRepeatPassword,
         createAccountOptionalCellphone, createAccountSignUp,
         createAccountUserRegisteredSuccess
    
}

extension StringKeys {
    var localized: String {
        return NSLocalizedString(self.rawValue, comment: "")
    }
}