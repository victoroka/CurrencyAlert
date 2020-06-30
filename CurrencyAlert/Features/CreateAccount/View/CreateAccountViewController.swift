//
//  CreateAccountViewController.swift
//  CurrencyChecker
//
//  Created by Victor Oka on 14/06/20.
//  Copyright © 2020 Victor Oka. All rights reserved.
//

import UIKit

final class CreateAccountViewController: UIViewController {

    private let viewModel: CreateAccountViewModel
    private var inputFields = [InputField]()
    
    // MARK: Screen Components
    private lazy var swipeIndicatorView: UIView = {
        let view = UIView(frame: .zero)
        view.layer.cornerRadius = 6
        view.backgroundColor = .lightGray
        return view
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView(frame: .zero)
        scroll.alwaysBounceVertical = false
        scroll.bounces = true
        return scroll
    }()
    
    private lazy var createAccountLabel: UILabel = {
        let label = UILabel()
        label.text = CreateAccountStrings.createAccountLabelText.rawValue
        label.font = UIFont.defaultBold(ofSize: 22)
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
    
    private lazy var firstNameTextField: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.backgroundColor = .defaultLightGray
        textField.borderStyle = .none
        textField.layer.cornerRadius = 6
        textField.font = UIFont.defaultRegular(ofSize: 14)
        textField.placeholder = CreateAccountStrings.firstNamePlaceholder.rawValue
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
        textField.placeholder = CreateAccountStrings.lastNamePlaceholder.rawValue
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
        textField.placeholder = CreateAccountStrings.emailPlaceholder.rawValue
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
        textField.placeholder = CreateAccountStrings.passwordPlaceholder.rawValue
        textField.setLeftPaddingPoints(15)
        textField.setRightPaddingPoints(15)
        textField.isSecureTextEntry = true
        textField.textContentType = .password
        return textField
    }()
    
    private lazy var repeatPasswordTextField: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.backgroundColor = .defaultLightGray
        textField.borderStyle = .none
        textField.layer.cornerRadius = 6
        textField.font = UIFont.defaultRegular(ofSize: 14)
        textField.placeholder = CreateAccountStrings.repeatPasswordPlaceholder.rawValue
        textField.setLeftPaddingPoints(15)
        textField.setRightPaddingPoints(15)
        textField.isSecureTextEntry = true
        textField.textContentType = .password
        return textField
    }()
    
    private lazy var phoneTextField: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.backgroundColor = .defaultLightGray
        textField.borderStyle = .none
        textField.layer.cornerRadius = 6
        textField.font = UIFont.defaultRegular(ofSize: 14)
        textField.placeholder = CreateAccountStrings.phonePlaceholder.rawValue
        textField.setLeftPaddingPoints(15)
        textField.setRightPaddingPoints(15)
        textField.keyboardType = .phonePad
        textField.textContentType = .telephoneNumber
        return textField
    }()
    
    private lazy var signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle(CreateAccountStrings.signUpButtonTitle.rawValue, for: .normal)
        button.tintColor = .white
        button.backgroundColor = .systemPurple
        button.titleLabel?.font = UIFont.defaultBold(ofSize: 14)
        button.layer.cornerRadius = 25
        button.addTarget(self, action: #selector(signUpAction), for: .touchUpInside)
        return button
    }()
    
    // MARK: View Controller Functions
    init(viewModel: CreateAccountViewModel) {
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
        setupTextFields()
        hideKeyboardWhenTappedAround()
    }
    
    private func setupViewModel() {
        viewModel.delegate = self
    }
    
    private func setupTextFields() {
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        repeatPasswordTextField.delegate = self
        phoneTextField.delegate = self
        
        inputFields.append(InputField(textField: firstNameTextField, type: .firstName, rules: [.notEmpty]))
        inputFields.append(InputField(textField: lastNameTextField, type: .lastName, rules: [.notEmpty]))
        inputFields.append(InputField(textField: emailTextField, type: .email, rules: [.validEmail, .notEmpty]))
        inputFields.append(InputField(textField: passwordTextField, type: .password, rules: [.notEmpty]))
        inputFields.append(InputField(textField: repeatPasswordTextField, type: .repeatPassword, rules: [.notEmpty]))
    }
    
    @objc private func dismissButtonAction() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func signUpAction() {
        if validate(fields: inputFields) && confirm(passwordTextField, repeatPasswordTextField) {
            CustomActivityIndicator.shared.showProgressView()
            viewModel.userCreateViewModel = UserCreateViewModel(firstName: firstNameTextField.text!, lastName: lastNameTextField.text!, email: emailTextField.text!, password: passwordTextField.text!, phone: phoneTextField.text!)
            viewModel.register()
        }
    }
    
    private func showAlertAndDismiss(with message: String) {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: LoginStrings.alertOkButtonLabel.rawValue, style: .default) { (action) in
            self.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
    }
}

// MARK: Text Field Delegate Protocol
extension CreateAccountViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        scrollView.setContentOffset(CGPoint(x: 0, y: (textField.superview?.frame.origin.y)!), animated: true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
    
}

// MARK: Create Account View Model Protocol
extension CreateAccountViewController: CreateAccountViewModelDelegate {
    
    func registerSuccess() {
        CustomActivityIndicator.shared.hideProgressView()
        showAlertAndDismiss(with: CreateAccountStrings.userRegisterSuccessMessage.rawValue)
    }
    
    func registerFailure() {
        CustomActivityIndicator.shared.hideProgressView()
    }
    
}

// MARK: Code View Protocol
extension CreateAccountViewController: CodeView {
    func buildViewHierarchy() {
        view.addSubview(swipeIndicatorView)
        view.addSubview(scrollView)
        
        scrollView.addSubview(createAccountLabel)
        textFieldStack.addArrangedSubview(firstNameTextField)
        textFieldStack.addArrangedSubview(lastNameTextField)
        textFieldStack.addArrangedSubview(emailTextField)
        textFieldStack.addArrangedSubview(passwordTextField)
        textFieldStack.addArrangedSubview(repeatPasswordTextField)
        textFieldStack.addArrangedSubview(phoneTextField)
        scrollView.addSubview(textFieldStack)
        scrollView.addSubview(signUpButton)
    }
    
    func setupConstraints() {
        swipeIndicatorView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().inset(20)
            make.height.equalTo(6)
            make.width.equalToSuperview().multipliedBy(0.4)
            make.centerX.equalToSuperview()
        }
        
        scrollView.snp.makeConstraints { (make) in
            make.top.equalTo(swipeIndicatorView.snp.bottom).offset(5)
            make.left.right.bottom.equalToSuperview()
        }
        
        createAccountLabel.snp.makeConstraints { (make) in
            make.top.equalTo(additionalSafeAreaInsets.top).inset(90)
            make.height.equalTo(40)
            make.centerX.equalToSuperview()
        }
        
        textFieldStack.snp.makeConstraints { (make) in
            make.top.equalTo(createAccountLabel.snp.bottom).offset(50)
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
        
        passwordTextField.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
        }
        
        repeatPasswordTextField.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
        }
        
        phoneTextField.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
        }
        
        signUpButton.snp.makeConstraints { (make) in
            make.top.equalTo(textFieldStack.snp.bottom).offset(70)
            make.height.equalTo(50)
            make.width.equalTo(130)
            make.centerX.equalToSuperview()
        }
    }
    
    func setupAdditionalConfigurarion() {
        view.backgroundColor = .white
    }
}
