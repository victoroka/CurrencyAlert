//
//  UserProfileViewController.swift
//  CurrencyAlert
//
//  Created by Victor Oka on 06/07/20.
//  Copyright © 2020 Alerta Câmbio. All rights reserved.
//

import UIKit

class UserProfileViewController: UIViewController {

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupNavigationBar()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.topItem?.title = UserProfileStrings.navigationBarTitle.rawValue
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.systemPurple]
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.systemPurple, NSAttributedString.Key.font: UIFont.defaultBold(ofSize: 32)]
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
    }
}
