//
//  CreateAlertPopupView.swift
//  CurrencyAlert
//
//  Created by Victor Oka on 15/07/20.
//  Copyright © 2020 Alerta Câmbio. All rights reserved.
//

import UIKit

final class CreateAlertPopupView: UIView {
    
    // MARK: View Components
    lazy var container: UIView = {
        let containerView = UIView()
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 24
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
    
    // MARK: View Functions
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = UIScreen.main.bounds
        setupView()
        animateIn()
    }
    
    required init?(coder: NSCoder) {
        fatalError(Constants.initFatalErrorDefaultMessage)
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
    }
    
    @objc private func animateIn() {
        container.transform = CGAffineTransform(translationX: 0, y: -frame.height)
        alpha = 1
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            self.container.transform = .identity
            self.alpha = 1
        })
    }
    
    @objc private func closeButtonPressed() {
        animateOut()
    }
}

// MARK: Code View Protocol
extension CreateAlertPopupView: CodeView {
    func buildViewHierarchy() {
        addSubview(container)
        container.addSubview(closeButton)
    }
    
    func setupConstraints() {
        container.snp.makeConstraints { (make) in
            make.centerY.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalToSuperview().multipliedBy(0.45)
        }
        closeButton.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(15)
            make.right.equalToSuperview().inset(20)
            make.height.equalTo(40)
            make.width.equalTo(55)
        }
    }
    
    func setupAdditionalConfigurarion() {
        backgroundColor = UIColor.lightGray.withAlphaComponent(0.6)
    }
}
