//
//  Alert.swift
//  CurrencyAlert
//
//  Created by Victor Oka on 15/07/20.
//  Copyright © 2020 Alerta Câmbio. All rights reserved.
//

import Foundation

struct Alert: Codable {
    
    let code: String
    let value: String
    let currentCurrencyValue: String
    let dateCreated: String
    
    enum CodingKeys: String, CodingKey {
        case code = "code"
        case value = "alert_value"
        case currentCurrencyValue = "currency_value"
        case dateCreated = "date_created"
    }
}
