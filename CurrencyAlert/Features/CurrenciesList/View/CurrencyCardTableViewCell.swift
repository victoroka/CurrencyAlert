//
//  CurrencyCardTableViewCell.swift
//  CurrencyChecker
//
//  Created by Victor Oka on 15/06/20.
//  Copyright © 2020 Victor Oka. All rights reserved.
//

import UIKit

final class CurrencyCardTableViewCell: UITableViewCell {
    
    // MARK: Cell Components
    private lazy var cardView: UIView = {
        let card = UIView(frame: .zero)
        card.layer.cornerRadius = 14.0
        card.layer.shadowColor = UIColor.darkGray.cgColor
        card.layer.shadowOffset = CGSize(width: 1.0, height: 2.0)
        card.layer.shadowRadius = 6.0
        card.layer.shadowOpacity = 0.6
        card.backgroundColor = .white
        return card
    }()
    
    lazy var currencyNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.defaultBold(ofSize: 16)
        label.tintColor = .black
        return label
    }()
    
    lazy var currencyValueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.defaultRegular(ofSize: 16)
        label.tintColor = .black
        return label
    }()
    
    // MARK: UITableViewCell Functions
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError(Constants.initFatalErrorDefaultMessage)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

// MARK: Code View Protocol
extension CurrencyCardTableViewCell: CodeView {
    
    func buildViewHierarchy() {
        cardView.addSubview(currencyNameLabel)
        cardView.addSubview(currencyValueLabel)
        addSubview(cardView)
    }
    
    func setupConstraints() {
        cardView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().inset(20)
            make.height.equalTo(100)
            make.centerX.equalToSuperview()
        }
        
        currencyNameLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().inset(20)
            make.height.equalTo(28)
        }
        
        currencyValueLabel.snp.makeConstraints { (make) in
            make.top.equalTo(currencyNameLabel.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().inset(20)
            make.height.equalTo(28)
        }
    }
    
    func setupAdditionalConfigurarion() {
        
    }
}
