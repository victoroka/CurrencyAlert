//
//  String+Extension.swift
//  CurrencyChecker
//
//  Created by Victor Oka on 23/06/20.
//  Copyright © 2020 Victor Oka. All rights reserved.
//

import Foundation

extension String {
    
    func toBase64() -> String {
        return Data(self.utf8).base64EncodedString()
    }
    
}
