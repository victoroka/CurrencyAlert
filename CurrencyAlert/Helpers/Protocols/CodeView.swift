//
//  CodeView.swift
//  CurrencyChecker
//
//  Created by Victor Oka on 09/06/20.
//  Copyright © 2020 Victor Oka. All rights reserved.
//

import Foundation
import SnapKit

protocol CodeView {
    func buildViewHierarchy()
    func setupConstraints()
    func setupAdditionalConfigurarion()
    func setupView()
}

extension CodeView {
    func setupView() {
        buildViewHierarchy()
        setupConstraints()
        setupAdditionalConfigurarion()
    }
}
