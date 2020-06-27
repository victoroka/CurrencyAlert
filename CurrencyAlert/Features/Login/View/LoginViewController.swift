//
//  LoginViewController.swift
//  CurrencyChecker
//
//  Created by Victor Oka on 13/06/20.
//  Copyright © 2020 Victor Oka. All rights reserved.
//

import UIKit

final class LoginViewController: UIViewController {

    private let viewModel: LoginViewModel
    
    // MARK: Screen Components
    private var labelStack: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    private lazy var welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = LoginStrings.welcomeLabelText.rawValue
        label.font = UIFont.defaultBold(ofSize: 22)
       return label
    }()
    
    private lazy var signInLabel: UILabel = {
        let label = UILabel()
        label.text = LoginStrings.signInLabelText.rawValue
        label.font = UIFont.defaultRegular(ofSize: 16)
        return label
    }()
    
    private var textFieldStack: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 15
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    private lazy var emailTextField: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.backgroundColor = .defaultLightGray
        textField.borderStyle = .none
        textField.layer.cornerRadius = 6
        textField.font = UIFont.defaultRegular(ofSize: 14)
        textField.placeholder = LoginStrings.emailPlaceholder.rawValue
        textField.setLeftPaddingPoints(15)
        textField.setRightPaddingPoints(15)
        textField.keyboardType = .emailAddress
        textField.textContentType = .emailAddress
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        return textField
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.backgroundColor = .defaultLightGray
        textField.borderStyle = .none
        textField.layer.cornerRadius = 6
        textField.font = UIFont.defaultRegular(ofSize: 14)
        textField.placeholder = LoginStrings.passwordPlaceholder.rawValue
        textField.setLeftPaddingPoints(15)
        textField.setRightPaddingPoints(15)
        textField.isSecureTextEntry = true
        textField.textContentType = .password
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        return textField
    }()
    
    private lazy var signInButton: UIButton = {
        let button = UIButton()
        button.setTitle(LoginStrings.signInButtonTitle.rawValue, for: .normal)
        button.tintColor = .white
        button.backgroundColor = .systemPurple
        button.titleLabel?.font = UIFont.defaultBold(ofSize: 14)
        button.layer.cornerRadius = 25
        button.addTarget(self, action: #selector(signInAction), for: .touchUpInside)
        return button
    }()
    
    private var signUpStack: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    private lazy var dontHaveAnAccountLabel: UILabel = {
        let label = UILabel()
        label.text = LoginStrings.dontHaveAnAccountLabelText.rawValue
        label.font = UIFont.defaultRegular(ofSize: 14)
        return label
    }()
    
    private lazy var goToSignUpButton: UIButton = {
        let button = UIButton()
        button.setTitle(LoginStrings.goToSignUpButtonTitle.rawValue, for: .normal)
        button.setTitleColor(.systemPurple, for: .normal)
        button.titleLabel?.font = UIFont.defaultBold(ofSize: 15)
        button.addTarget(self, action: #selector(goToSignUpAction), for: .touchUpInside)
        return button
    }()
    
    // MARK: View Controller Functions
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError(Constants.initFatalErrorDefaultMessage)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupViewModel()
        hideKeyboardWhenTappedAround()
    }
    
    private func setupViewModel() {
        viewModel.delegate = self
    }
    
    private func setupTextFields() {
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    @objc private func signInAction(sender: UIButton!) {
        // TODO: Implement login validation
        guard let email = emailTextField.text else { return }
        guard let password =  passwordTextField.text else { return }
        if !email.isEmpty && !password.isEmpty {
            if email.isValidEmail {
                let user = UserLoginViewModel(email: emailTextField.text!, password: passwordTextField.text!)
                viewModel.userLoginViewModel = user
                viewModel.login()
            }
        }
    }
    
    @objc private func goToSignUpAction(sender: UIButton!) {
        let viewModel = CreateAccountViewModel(networkingService: NetworkingAPI())
        let createAccountViewController = CreateAccountViewController(viewModel: viewModel)
        present(createAccountViewController, animated: true, completion: nil)
    }
}

// MARK: Login View Model Delegate
extension LoginViewController: LoginViewModelDelegate {
    
    func loginSuccess() {
        let viewModel = CurrenciesListViewModel(networkingService: NetworkingAPI())
        let currenciesListViewController = CurrenciesListViewController(viewModel: viewModel)
        let homeViewController = UINavigationController(rootViewController: currenciesListViewController)
        presentInFullScreen(homeViewController, animated: true)
    }
    
    func loginFailure() {
        print("Login Failure")
    }
    
}

// MARK: UITextFieldDelegate
extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

// MARK: Code View Protocol
extension LoginViewController: CodeView {
    
    func buildViewHierarchy() {
        labelStack.addArrangedSubview(welcomeLabel)
        labelStack.addArrangedSubview(signInLabel)
        view.addSubview(labelStack)
        
        textFieldStack.addArrangedSubview(emailTextField)
        textFieldStack.addArrangedSubview(passwordTextField)
        view.addSubview(textFieldStack)
        view.addSubview(signInButton)
        
        signUpStack.addArrangedSubview(dontHaveAnAccountLabel)
        signUpStack.addArrangedSubview(goToSignUpButton)
        view.addSubview(signUpStack)
    }
    
    func setupConstraints() {
        labelStack.snp.makeConstraints { (make) in
            make.top.equalTo(additionalSafeAreaInsets.top).inset(100)
            make.height.equalTo(80)
            make.centerX.equalToSuperview()
        }
        
        textFieldStack.snp.makeConstraints { (make) in
            make.top.equalTo(labelStack.snp.bottom).offset(30)
            make.left.equalToSuperview().offset(45)
            make.right.equalToSuperview().inset(45)
        }
        
        emailTextField.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
        }
        
        passwordTextField.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
        }
        
        signInButton.snp.makeConstraints { (make) in
            make.top.equalTo(textFieldStack.snp.bottom).offset(55)
            make.height.equalTo(50)
            make.width.equalTo(130)
            make.centerX.equalToSuperview()
        }
        
        signUpStack.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().inset(45)
            make.width.equalToSuperview().multipliedBy(0.7)
            make.height.equalTo(55)
            make.centerX.equalToSuperview()
        }
        
        dontHaveAnAccountLabel.snp.makeConstraints { (make) in
            make.width.equalToSuperview().multipliedBy(0.6)
        }
        
        goToSignUpButton.snp.makeConstraints { (make) in
            make.width.equalToSuperview().multipliedBy(0.4)
        }
    }
    
    func setupAdditionalConfigurarion() {
        view.backgroundColor = .white
    }
    
}
