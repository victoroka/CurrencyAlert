//
//  Constants.swift
//  CurrencyChecker
//
//  Created by Victor Oka on 14/06/20.
//  Copyright © 2020 Victor Oka. All rights reserved.
//

import Foundation

struct Constants {
    
    // MARK: - General
    static let API_KEY = "Dy5QBxdJxM7DFL6uVnQhM1bpoqVruLxP4BkJ5lEc"
    static let API_HOST = "jl4jljallk.execute-api.us-east-1.amazonaws.com"
    static let API_SCHEME = "https"
    
    static let AUTH_KEY = "Auth"
    static let EMAIL_KEY = "Email"
    static let FIRST_NAME_KEY = "FirstName"
    static let LAST_NAME_KEY = "LastName"
    static let PHONE_KEY = "Phone"
    
    static let initFatalErrorDefaultMessage = "init(coder:) has not been implemented"
    static let mappingErrorMessage = "mapping error"
    static let badUrlErrorMessage = "bad URL error"
    static let emptyResponseErrorMessage = "empty response error"
    
    static let loginGenericError = "login failure"
    static let createAlertGenericError = "create alert failure"
    
    static let notificationBellImageName = "notification_bell"
    
    // MARK: - TabBar
    struct TabBar {
        static let addAlertIconImageName = "add_alert"
        static let alertsIconImageName = "alerts"
        static let profileIconImageName = "profile"
        static let alertsItemTitle = "alertas"
        static let profileItemTitle = "perfil"
    }
    
    // MARK: - Request
    struct Request {
        static let apiHeaderField = "x-api-key"
        static let authorizationHeaderField = "Authorization"
        
        struct Dev {
            static let currenciesListPath = "/dev/currency"
            static let registerUserPath = "/dev/user"
            static let loginPath = "/dev/login"
            static let alertListPath = "/dev/currency/alert"
        }
        
        struct Prod {
            static let currenciesListPath = "/prd/currency"
            static let registerUserPath = "/prd/user"
            static let loginPath = "/prd/login"
            static let alertListPath = "/prd/currency/alert"
        }
        
        struct Method {
            static let POST = "POST"
            static let GET = "GET"
            static let PATCH = "PATCH"
            static let PUT = "PUT"
            static let DELETE = "DELETE"
        }
    }
    
    // MARK: - Parameters
    struct Parameters {
        static let email = "email"
        static let password = "password"
        static let phone = "phone"
        static let firstName = "first_name"
        static let lastName = "last_name"
        static let code = "code"
        static let alertValue = "alert_value"
        static let currentValue = "current_value"
    }
}
