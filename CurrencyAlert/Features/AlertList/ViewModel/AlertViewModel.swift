//
//  CurrencyViewModel.swift
//  CurrencyChecker
//
//  Created by Victor Oka on 20/06/20.
//  Copyright © 2020 Victor Oka. All rights reserved.
//

import Foundation

// MARK: Alert View Model
struct AlertViewModel {
    
    let code: String
    let value: String
    let currentCurrencyValue: String
    let dateCreated: String
    
    init(alert: Alert) {
        self.code = alert.code
        self.value = alert.value
        self.currentCurrencyValue = alert.currentCurrencyValue
        self.dateCreated = alert.dateCreated
    }
}
