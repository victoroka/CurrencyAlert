//
//  User.swift
//  CurrencyAlert
//
//  Created by Victor Oka on 28/08/20.
//  Copyright © 2020 Alerta Câmbio. All rights reserved.
//

import Foundation

struct User: Codable {
    
    let email: String
    let firstName: String
    let lastName: String
    let phone: String?
    
    enum CodingKeys: String, CodingKey {
        case email = "email"
        case firstName = "firstName"
        case lastName = "lastName"
        case phone = "phone"
    }
    
}
