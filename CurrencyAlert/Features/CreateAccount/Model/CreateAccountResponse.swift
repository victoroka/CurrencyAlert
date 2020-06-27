//
//  CreateAccountResponseModel.swift
//  CurrencyChecker
//
//  Created by Victor Oka on 21/06/20.
//  Copyright © 2020 Victor Oka. All rights reserved.
//

import Foundation

// MARK: Create Account Response Entity
struct CreateAccountResponse: Codable {
    
    let message: String
    
    enum CodingKeys: String, CodingKey {
        case message = "message"
    }
}
