//
//  UserProfileViewController.swift
//  CurrencyAlert
//
//  Created by Victor Oka on 06/07/20.
//  Copyright © 2020 Alerta Câmbio. All rights reserved.
//

import UIKit

final class UserProfileViewController: UIViewController {

    lazy var logoutButton: UIButton = {
        let button = UIButton()
        button.setTitle(UserProfileStrings.logoutButtonTitle.rawValue, for: .normal)
        button.setTitleColor(.systemPurple, for: .normal)
        button.titleLabel?.font = UIFont.defaultBold(ofSize: 14)
        button.addTarget(self, action: #selector(logoutButtonPressed), for: .touchUpInside)
        return button
    }()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupNavigationBar()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        view.backgroundColor = .white
    }
    
    private func setupNavigationBar() {
        tabBarController?.navigationItem.title = UserProfileStrings.navigationBarTitle.rawValue
        tabBarController?.navigationItem.searchController = nil
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.systemPurple]
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.systemPurple, NSAttributedString.Key.font: UIFont.defaultBold(ofSize: 32)]
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
    }
    
    @objc private func logoutButtonPressed() {
        resetUserDefaults()
        goToLoginViewController()
    }
    
    private func goToLoginViewController() {
        let viewModel = LoginViewModel(networkingService: NetworkingAPI())
        let viewController = LoginViewController(viewModel: viewModel)
        presentInFullScreen(viewController, animated: true)
    }
    
    private func resetUserDefaults() {
        let defaults = UserDefaults.standard
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            defaults.removeObject(forKey: key)
        }
    }
}

extension UserProfileViewController: CodeView {
    func buildViewHierarchy() {
        view.addSubview(logoutButton)
    }
    
    func setupConstraints() {
        logoutButton.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(25)
            make.left.equalToSuperview().offset(20)
            make.height.equalTo(40)
            make.width.equalTo(55)
        }
    }
    
    func setupAdditionalConfigurarion() {}
}
