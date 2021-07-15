//
//  UITableView+Extension.swift
//  CurrencyAlert
//
//  Created by Victor Oka on 17/06/21.
//  Copyright © 2021 Alerta Câmbio. All rights reserved.
//

import UIKit

extension UITableView {
    
    func register<T: UITableViewCell>(cellType: T.Type) {
        register(T.self, forCellReuseIdentifier: String(describing: cellType))
    }
    
    func dequeue<T: UITableViewCell>(cell: T.Type, indexPath: IndexPath) -> T {
        return dequeueReusableCell(withIdentifier: String(describing: cell), for: indexPath) as! T
    }
    
}
