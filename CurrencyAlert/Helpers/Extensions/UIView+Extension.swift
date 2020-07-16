//
//  UIView+Extension.swift
//  CurrencyAlert
//
//  Created by Victor Oka on 16/07/20.
//  Copyright © 2020 Alerta Câmbio. All rights reserved.
//

import UIKit

extension UIView {
    
    func validate(fields: [InputField]) -> Bool {
        let validator = Validator()
        var validation = true
        
        for field in fields {
            field.isValid = validator.validate(inputField: field, with: field.rules)
            field.textField.animate(for: field.isValid)
            if !field.isValid {
                validation = false
            }
        }
        return validation
    }
    
}
