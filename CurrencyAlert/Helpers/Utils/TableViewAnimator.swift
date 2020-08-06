//
//  TableViewAnimator.swift
//  CurrencyAlert
//
//  Created by Victor Oka on 01/08/20.
//  Copyright © 2020 Alerta Câmbio. All rights reserved.
//

import UIKit

typealias TableCellAnimation = (UITableViewCell, IndexPath, UITableView) -> Void

final class TableViewAnimator {
    
    private let animation: TableCellAnimation
    
    init(animation: @escaping TableCellAnimation) {
        self.animation = animation
    }
    
    func animate(cell: UITableViewCell, at indexPath: IndexPath, in tableView: UITableView) {
        animation(cell, indexPath, tableView)
    }
}
