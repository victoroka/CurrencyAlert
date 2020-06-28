//
//  Endpoint.swift
//  CurrencyChecker
//
//  Created by Victor Oka on 16/06/20.
//  Copyright © 2020 Victor Oka. All rights reserved.
//

import Foundation

struct Endpoint {
    
    private let path: String
    
    var url: URL? {
        var components = URLComponents()
        components.scheme = Constants.API_SCHEME
        components.host = Constants.API_HOST
        components.path = path
        return components.url
    }
    
    static func build(for path: String) -> Endpoint {
        return Endpoint(path: path)
    }
    
}
