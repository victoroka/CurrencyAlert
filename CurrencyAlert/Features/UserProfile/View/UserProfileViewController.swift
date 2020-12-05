//
//  UserProfileViewController.swift
//  CurrencyAlert
//
//  Created by Victor Oka on 06/07/20.
//  Copyright © 2020 Alerta Câmbio. All rights reserved.
//

import UIKit

final class UserProfileViewController: UIViewController {

    // MARK: Screen Components
    lazy var logoutButton: UIButton = {
        let button = UIButton()
        button.setTitle(UserProfileStrings.logoutButtonTitle.rawValue, for: .normal)
        button.setTitleColor(.systemPurple, for: .normal)
        button.backgroundColor = .white
        button.titleLabel?.font = UIFont.defaultBold(ofSize: 14)
        button.layer.cornerRadius = 25
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemPurple.cgColor
        button.addTarget(self, action: #selector(logoutButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private var textFieldStack: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 15
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    private lazy var firstNameTextField: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.backgroundColor = .defaultLightGray
        textField.borderStyle = .none
        textField.layer.cornerRadius = 6
        textField.font = UIFont.defaultRegular(ofSize: 14)
        textField.placeholder = StringKeys.createAccountFirstName.localized
        textField.setLeftPaddingPoints(15)
        textField.setRightPaddingPoints(15)
        textField.keyboardType = .default
        textField.textContentType = .name
        textField.autocapitalizationType = .words
        textField.autocorrectionType = .no
        return textField
    }()
    
    private lazy var lastNameTextField: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.backgroundColor = .defaultLightGray
        textField.borderStyle = .none
        textField.layer.cornerRadius = 6
        textField.font = UIFont.defaultRegular(ofSize: 14)
        textField.placeholder = StringKeys.createAccountLastName.localized
        textField.setLeftPaddingPoints(15)
        textField.setRightPaddingPoints(15)
        textField.keyboardType = .default
        textField.textContentType = .name
        textField.autocapitalizationType = .words
        textField.autocorrectionType = .no
        return textField
    }()
    
    private lazy var emailTextField: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.backgroundColor = .defaultLightGray
        textField.borderStyle = .none
        textField.layer.cornerRadius = 6
        textField.font = UIFont.defaultRegular(ofSize: 14)
        textField.placeholder = StringKeys.createAccountEmail.localized
        textField.setLeftPaddingPoints(15)
        textField.setRightPaddingPoints(15)
        textField.keyboardType = .emailAddress
        textField.textContentType = .emailAddress
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        return textField
    }()
    
    private lazy var phoneTextField: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.backgroundColor = .defaultLightGray
        textField.borderStyle = .none
        textField.layer.cornerRadius = 6
        textField.font = UIFont.defaultRegular(ofSize: 14)
        textField.placeholder = StringKeys.createAccountOptionalCellphone.localized
        textField.setLeftPaddingPoints(15)
        textField.setRightPaddingPoints(15)
        textField.keyboardType = .phonePad
        textField.textContentType = .telephoneNumber
        return textField
    }()
    
    private lazy var updateButton: UIButton = {
        let button = UIButton()
        button.setTitle(UserProfileStrings.updateButtonTitle.rawValue, for: .normal)
        button.tintColor = .white
        button.backgroundColor = .systemPurple
        button.titleLabel?.font = UIFont.defaultBold(ofSize: 14)
        button.layer.cornerRadius = 25
        button.addTarget(self, action: #selector(updateButtonPressed), for: .touchUpInside)
        return button
    }()
    
    // MARK: View Controller Functions
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupNavigationBar()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        loadUserInformation()
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
    
    private func loadUserInformation() {
        firstNameTextField.text = UserDefaults.standard.string(forKey: Constants.FIRST_NAME_KEY)
        lastNameTextField.text = UserDefaults.standard.string(forKey: Constants.LAST_NAME_KEY)
        emailTextField.text = UserDefaults.standard.string(forKey: Constants.EMAIL_KEY)
        phoneTextField.text = UserDefaults.standard.string(forKey: Constants.PHONE_KEY)
    }
    
    @objc private func logoutButtonPressed() {
        resetUserDefaults()
        goToLoginViewController()
    }
    
    @objc private func updateButtonPressed() {
        // TODO: Implement update logic
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

// MARK: Code View Protocol
extension UserProfileViewController: CodeView {
    func buildViewHierarchy() {
        view.addSubview(logoutButton)
        textFieldStack.addArrangedSubview(firstNameTextField)
        textFieldStack.addArrangedSubview(lastNameTextField)
        textFieldStack.addArrangedSubview(emailTextField)
        textFieldStack.addArrangedSubview(phoneTextField)
        view.addSubview(textFieldStack)
        view.addSubview(updateButton)
    }
    
    func setupConstraints() {
        logoutButton.snp.makeConstraints { (make) in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(30)
            make.height.equalTo(50)
            make.width.equalToSuperview().multipliedBy(0.85)
            make.centerX.equalToSuperview()
        }
        
        textFieldStack.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(25)
            make.left.equalTo(view.snp.left).offset(45)
            make.right.equalTo(view.snp.right).inset(45)
        }
        
        firstNameTextField.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
        }
        
        lastNameTextField.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
        }
        
        emailTextField.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
        }
        
        phoneTextField.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
        }
        
        updateButton.snp.makeConstraints { (make) in
            make.top.equalTo(textFieldStack.snp.bottom).offset(70)
            make.height.equalTo(50)
            make.width.equalTo(130)
            make.centerX.equalToSuperview()
        }
    }
    
    func setupAdditionalConfigurarion() {}
}
