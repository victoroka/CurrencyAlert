//
//  Utils.swift
//  CurrencyAlert
//
//  Created by Victor Oka on 14/07/20.
//  Copyright © 2020 Alerta Câmbio. All rights reserved.
//

import Foundation

struct Utils {
    
    static func setupIconFor(currency: String) -> String {
        switch currency {
        case "Dólar Comercial":
            return "US$"
        case "Dólar Turismo":
            return "US$"
        case "Dólar Canadense":
            return "C$"
        case "Euro":
            return "€"
        case "Libra Esterlina":
            return "£"
        case "Peso Argentino":
            return "N$"
        case "Bitcoin":
            return "₿"
        case "Litecoin":
            return "Ł"
        case "Iene Japonês":
            return "¥"
        case "Franco Suíço":
            return "CHF"
        case "Dólar Australiano":
            return "$"
        case "Yuan Chinês":
            return "¥"
        case "Novo Shekel Israelense":
            return "₪"
        case "Ethereum":
            return "Ξ"
        case "Ripple":
            return "XRP"
        default:
            return ""
        }
    }
    
}
