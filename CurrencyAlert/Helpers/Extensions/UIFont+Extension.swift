//
//  UIFont+Extension.swift
//  CurrencyChecker
//
//  Created by Victor Oka on 13/06/20.
//  Copyright © 2020 Victor Oka. All rights reserved.
//

import UIKit

extension UIFont {
    
    private static func customFont(name: String, size: CGFloat) -> UIFont {
        let font = UIFont(name: name, size: size)
        assert(font != nil, "Can't load font: \(name)")
        return font ?? UIFont.systemFont(ofSize: size)
    }
    
    static func defaultRegular(ofSize size: CGFloat) -> UIFont {
        return customFont(name: "Avenir-Medium", size: size)
    }
    
    static func defaultBold(ofSize size: CGFloat) -> UIFont {
        return customFont(name: "Avenir-Black", size: size)
    }
    
}
