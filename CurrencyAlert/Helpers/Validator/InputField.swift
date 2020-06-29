//
//  InputField.swift
//  CurrencyAlert
//
//  Created by Victor Oka on 29/06/20.
//  Copyright © 2020 Alerta Câmbio. All rights reserved.
//

import UIKit

enum InputFieldType {
    case email
    case password
    case firstName
    case lastName
    case phone
}

class InputField {
    
    let textField: UITextField
    let type: InputFieldType
    let rules: [Rule]
    var isValid: Bool = false
    
    
    init(textField: UITextField, type: InputFieldType, rules: [Rule]) {
        self.textField = textField
        self.type = type
        self.rules = rules
    }
}
