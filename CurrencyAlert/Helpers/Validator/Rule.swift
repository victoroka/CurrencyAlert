//
//  Rule.swift
//  CurrencyAlert
//
//  Created by Victor Oka on 29/06/20.
//  Copyright © 2020 Alerta Câmbio. All rights reserved.
//

import Foundation

struct Rule {
    /// Return nil if matches, true otherwise
    let check: (String) -> Bool?
    
    static let notEmpty = Rule(check: {
        return $0.isEmpty ? false : true
    })
}
