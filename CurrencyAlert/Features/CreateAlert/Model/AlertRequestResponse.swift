//
//  CreateAlertResponse.swift
//  CurrencyAlert
//
//  Created by Victor Oka on 15/07/20.
//  Copyright © 2020 Alerta Câmbio. All rights reserved.
//

import Foundation

// MARK: Alert Request Response Entity
struct AlertRequestResponse: Codable, Error {
    
    let message: String
    
    enum CodingKeys: String, CodingKey {
        case message = "message"
    }
}
