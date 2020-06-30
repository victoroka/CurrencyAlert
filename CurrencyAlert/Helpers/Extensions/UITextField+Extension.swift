//
//  UITextField+Extension.swift
//  CurrencyChecker
//
//  Created by Victor Oka on 14/06/20.
//  Copyright © 2020 Victor Oka. All rights reserved.
//

import UIKit

extension UITextField {
    
    /// Changes the appearance of the TextField if valid or invalid
    func animate(for validation: Bool) {
        if validation {
            UIView.animate(withDuration: 0.6) {
                self.backgroundColor = .defaultLightGray
                self.layer.borderWidth = 0.0
                self.borderStyle = .none
            }
        } else {
            UIView.animate(withDuration: 0.6) {
                self.layer.borderWidth = 1.0
                self.layer.borderColor = UIColor.red.withAlphaComponent(0.6).cgColor
                self.backgroundColor = UIColor.red.withAlphaComponent(0.2)
            }
        }
    }
    
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
    
}
