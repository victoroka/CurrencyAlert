//
//  CreateAlertPopupView.swift
//  CurrencyAlert
//
//  Created by Victor Oka on 15/07/20.
//  Copyright © 2020 Alerta Câmbio. All rights reserved.
//

import UIKit

final class CreateAlertPopupView: UIView {
    
    private var currencyCode: String
    private var currencyCurrentValue: String
    private let createAlertPopupViewModel: CreateAlertPopupViewModel
    
    private var inputFields = [InputField]()
    
    // MARK: View Components
    lazy var container: UIView = {
        let containerView = UIView()
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 24
        containerView.layer.shadowColor = UIColor.darkGray.cgColor
        containerView.layer.shadowOffset = CGSize(width: 1.0, height: 2.0)
        containerView.layer.shadowRadius = 6.0
        containerView.layer.shadowOpacity = 0.8
        return containerView
    }()
    
    lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setTitle(CreateAlertStrings.closeButtonTitle.rawValue, for: .normal)
        button.setTitleColor(.systemPurple, for: .normal)
        button.titleLabel?.font = UIFont.defaultBold(ofSize: 14)
        button.addTarget(self, action: #selector(closeButtonPressed), for: .touchUpInside)
        return button
    }()
    
    lazy var messageLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.defaultRegular(ofSize: 17)
        label.tintColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private var inputStack: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .horizontal
        stackView.alignment = .trailing
        stackView.spacing = 10
        stackView.distribution = .fill
        return stackView
    }()
    
    lazy var currencyCodeLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = CreateAlertStrings.defaultinputCurrencyCode.rawValue
        label.font = UIFont.defaultBold(ofSize: 20)
        label.tintColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var valueTextField: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        textField.backgroundColor = .defaultLightGray
        textField.borderStyle = .none
        textField.layer.cornerRadius = 6
        textField.font = UIFont.defaultRegular(ofSize: 20)
        textField.placeholder = CreateAlertStrings.valueInputPlaceholder.rawValue
        textField.setLeftPaddingPoints(15)
        textField.setRightPaddingPoints(15)
        textField.keyboardType = .numberPad
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        return textField
    }()
    
    private lazy var createAlertButton: UIButton = {
        let button = UIButton()
        button.setTitle(CreateAlertStrings.createAlertButtonTitle.rawValue, for: .normal)
        button.tintColor = .white
        button.backgroundColor = .systemPurple
        button.titleLabel?.font = UIFont.defaultBold(ofSize: 16)
        button.layer.cornerRadius = 25
        button.addTarget(self, action: #selector(createAlert), for: .touchUpInside)
        return button
    }()
    
    // MARK: View Functions
    init(code: String, currentValue: String, name: String, viewModel: CreateAlertPopupViewModel, frame: CGRect) {
        currencyCode = code
        currencyCurrentValue = currentValue
        createAlertPopupViewModel = viewModel
        super.init(frame: frame)
        self.frame = UIScreen.main.bounds
        messageLabel.text = "\(CreateAlertStrings.messageLabelPrefix.rawValue)\n\(name) \(CreateAlertStrings.messageLabelSufix.rawValue)"
        setupView()
        setupViewModel()
        setupInputField()
        animateIn()
    }
    
    required init?(coder: NSCoder) {
        fatalError(Constants.initFatalErrorDefaultMessage)
    }
    
    private func setupViewModel() {
        createAlertPopupViewModel.delegate = self
    }
    
    private func setupInputField() {
        inputFields.append(InputField(textField: valueTextField, type: .currency, rules: [.notEmpty]))
    }
    
    @objc private func animateOut() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            self.container.transform = CGAffineTransform(translationX: 0, y: -self.frame.height)
            self.alpha = 0
        }) { (complete) in
            if complete {
                self.removeFromSuperview()
            }
        }
        valueTextField.resignFirstResponder()
    }
    
    @objc private func animateIn() {
        container.transform = CGAffineTransform(translationX: 0, y: -frame.height)
        alpha = 1
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            self.container.transform = .identity
            self.alpha = 1
        })
        valueTextField.becomeFirstResponder()
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        if let amountString = textField.text?.currencyInputMask() {
            textField.text = amountString
        }
    }
    
    @objc private func createAlert() {
        if validate(fields: inputFields) {
            let alertValue = valueTextField.text!.requestFormat().floatValue
            createAlertPopupViewModel.create(alert: CreateAlertViewModel(code: currencyCode, value: alertValue, currentCurrencyValue: currencyCurrentValue.floatValue))
        }
    }
    
    @objc private func closeButtonPressed() {
        animateOut()
    }
}

// MARK: Create Alert Popup View Model Delegate
extension CreateAlertPopupView: CreateAlertPopupViewModelDelegate {
    func createAlertSuccess(message: String) {
        // TODO: Show message
        print("create alert success")
        animateOut()
    }
    
    func createAlertFailure(error: String) {
        // TODO: Show message
        print("create alert failure")
    }
}

// MARK: Code View Protocol
extension CreateAlertPopupView: CodeView {
    func buildViewHierarchy() {
        addSubview(container)
        container.addSubview(closeButton)
        container.addSubview(messageLabel)
        
        inputStack.addArrangedSubview(currencyCodeLabel)
        inputStack.addArrangedSubview(valueTextField)
        container.addSubview(inputStack)
        
        container.addSubview(createAlertButton)
    }
    
    func setupConstraints() {
        
        container.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview().multipliedBy(0.85)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalToSuperview().multipliedBy(0.36)
        }
        
        closeButton.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(12)
            make.right.equalToSuperview().inset(20)
            make.height.equalTo(30)
            make.width.equalTo(55)
        }
        
        messageLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(30)
            make.left.equalToSuperview().offset(25)
            make.right.equalToSuperview().inset(25)
            make.height.equalToSuperview().multipliedBy(0.30)
        }
        
        currencyCodeLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.20)
        }
        
        valueTextField.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
        }
        
        inputStack.snp.makeConstraints { (make) in
            make.top.equalTo(messageLabel.snp.bottom).offset(10)
            make.width.equalToSuperview().multipliedBy(0.55)
            make.height.equalToSuperview().multipliedBy(0.20)
            make.centerX.equalToSuperview()
        }
        
        createAlertButton.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().inset(16)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.4)
            make.height.equalToSuperview().multipliedBy(0.20)
        }
        
    }
    
    func setupAdditionalConfigurarion() {
        backgroundColor = UIColor.lightGray.withAlphaComponent(0.75)
    }
}
