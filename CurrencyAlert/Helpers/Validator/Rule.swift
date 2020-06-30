//
//  Rule.swift
//  CurrencyAlert
//
//  Created by Victor Oka on 29/06/20.
//  Copyright © 2020 Alerta Câmbio. All rights reserved.
//

import Foundation

struct Rule {
    /// Return true if matches, false otherwise
    let check: (String) -> Bool?
    
    static let notEmpty = Rule(check: {
        return $0.isEmpty ? false : true
    })
    
    static let validEmail = Rule(check: {
        let regex = #"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,64}"#
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: $0)
    })
}
