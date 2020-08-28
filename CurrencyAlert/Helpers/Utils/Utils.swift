//
//  Utils.swift
//  CurrencyAlert
//
//  Created by Victor Oka on 14/07/20.
//  Copyright © 2020 Alerta Câmbio. All rights reserved.
//

import Foundation

struct Utils {
    
    static func setupIconFor(currencyName: String) -> String {
        switch currencyName {
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
    
    static func setupIconFor(currencyCode: String) -> String {
        switch currencyCode {
        case "USD", "USDT":
            return "US$"
        case "CAD":
            return "C$"
        case "EUR":
            return "€"
        case "GBP":
            return "£"
        case "ARS":
            return "N$"
        case "BTC":
            return "₿"
        case "LTC":
            return "Ł"
        case "JPY":
            return "¥"
        case "CHF":
            return "CHF"
        case "AUD":
            return "$"
        case "CNY":
            return "¥"
        case "ILS":
            return "₪"
        case "ETH":
            return "Ξ"
        case "XRP":
            return "XRP"
        default:
            return ""
        }
    }
    
    static func toCurrencyString(value: Float) -> String {
        return "R$ \(String(describing: value).replacingOccurrences(of: ".", with: ","))"
    }
    
}
