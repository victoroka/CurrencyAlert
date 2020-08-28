//
//  LoginResponse.swift
//  CurrencyAlert
//
//  Created by Victor Oka on 30/06/20.
//  Copyright © 2020 Alerta Câmbio. All rights reserved.
//

import Foundation

// MARK: Login Response Entity
struct LoginResponse: Codable, Error {
    
    let message: String
    let user: User?
    
    enum CodingKeys: String, CodingKey {
        case message = "message"
        case user = "user"
    }
}
