//
//  Validator.swift
//  CurrencyAlert
//
//  Created by Victor Oka on 29/06/20.
//  Copyright © 2020 Alerta Câmbio. All rights reserved.
//

import UIKit

class Validator {
    
    func validate(text: String, with rules: [Rule]) -> Bool? {
        return rules.compactMap({ $0.check(text) }).first
    }

    func validate(inputField: InputField, with rules: [Rule]) -> Bool {
        guard let isValid = validate(text: inputField.textField.text ?? "", with: rules) else {
            return false
        }
        return isValid
    }
    
}
