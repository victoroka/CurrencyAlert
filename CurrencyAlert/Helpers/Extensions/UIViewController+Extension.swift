//
//  UIViewController+Extension.swift
//  CurrencyChecker
//
//  Created by Victor Oka on 15/06/20.
//  Copyright © 2020 Victor Oka. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func presentInFullScreen(_ viewController: UIViewController, animated: Bool, completion: (() -> Void)? = nil) {
        viewController.modalPresentationStyle = .fullScreen
        present(viewController, animated: animated, completion: completion)
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func validate(fields: [InputField]) -> Bool {
        let validator = Validator()
        var validation = true
        
        for field in fields {
            field.isValid = validator.validate(inputField: field, with: field.rules)
            field.textField.animate(for: field.isValid)
            if !field.isValid {
                validation = false
            }
        }
        return validation
    }
    
    func confirm(_ inputField: UITextField, _ inputFieldConfirmation: UITextField) -> Bool {
        let validator = Validator()
        let confirmation = validator.confirm(inputField, inputFieldConfirmation)

        inputField.animate(for: confirmation)
        inputFieldConfirmation.animate(for: confirmation)
        return confirmation
    }
    
}
