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
    
}

extension StringKeys {
    var localized: String {
        return NSLocalizedString(self.rawValue, comment: "")
    }
}
