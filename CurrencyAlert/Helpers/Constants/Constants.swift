//
//  Constants.swift
//  CurrencyChecker
//
//  Created by Victor Oka on 14/06/20.
//  Copyright © 2020 Victor Oka. All rights reserved.
//

import Foundation

struct Constants {
    
    static let API_KEY = "Dy5QBxdJxM7DFL6uVnQhM1bpoqVruLxP4BkJ5lEc"
    static let API_HOST = "jl4jljallk.execute-api.us-east-1.amazonaws.com"
    static let API_SCHEME = "https"
    
    static let AUTH_KEY = "Auth"
    
    static let initFatalErrorDefaultMessage = "init(coder:) has not been implemented"
    
    struct Request {
        static let apiHeaderField = "x-api-key"
        static let authorizationHeaderField = "Authorization"
        
        struct Dev {
            static let currenciesListPath = "/dev/currency"
            static let registerUserPath = "/dev/user"
            static let loginPath = "/dev/login"
        }
        
        struct Prod {
            static let currenciesListPath = "/prd/currency"
            static let registerUserPath = "/prd/user"
        }
        
        struct Method {
            static let POST = "POST"
            static let GET = "GET"
            static let PATCH = "PATCH"
            static let PUT = "PUT"
            static let DELETE = "DELETE"
        }
    }
}
