//
//  Currency.swift
//  CurrencyChecker
//
//  Created by Victor Oka on 09/06/20.
//  Copyright © 2020 Victor Oka. All rights reserved.
//

import Foundation

// MARK: Currency Entity
struct Currency: Codable {
    
    let code: String
    let codeIn: String
    let name: String
    let high: String
    let low: String
    let percentageChange: String
    let ask: String
    let createDate: String
    
    enum CodingKeys: String, CodingKey {
        case code = "code"
        case codeIn = "codein"
        case name = "name"
        case high = "high"
        case low = "low"
        case percentageChange = "pctChange"
        case ask = "ask"
        case createDate = "create_date"
    }
    
}
