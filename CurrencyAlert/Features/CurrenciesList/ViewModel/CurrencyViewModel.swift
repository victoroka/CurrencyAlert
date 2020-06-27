//
//  CurrencyViewModel.swift
//  CurrencyChecker
//
//  Created by Victor Oka on 20/06/20.
//  Copyright © 2020 Victor Oka. All rights reserved.
//

import Foundation

// MARK: Currency View Model
struct CurrencyViewModel {
    
    let code: String
    let codeIn: String
    let name: String
    let high: String
    let low: String
    let percentageChange: String
    let ask: String
    let createDate: String
    
    init(currency: Currency) {
        self.code = currency.code
        self.codeIn = currency.codeIn
        self.name = currency.name
        self.high = currency.high
        self.low = currency.low
        self.percentageChange = currency.percentageChange
        self.ask = currency.ask
        self.createDate = currency.createDate
    }
}
