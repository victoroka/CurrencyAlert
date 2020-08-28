//
//  CurrencyCardTableViewCell.swift
//  CurrencyChecker
//
//  Created by Victor Oka on 15/06/20.
//  Copyright © 2020 Victor Oka. All rights reserved.
//

import UIKit

final class AlertCardTableViewCell: UITableViewCell {
    
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
    
    lazy var currencyIconLabel: UILabel = {
        let label = UILabel()
        label.layer.masksToBounds = true
        label.font = UIFont.defaultBold(ofSize: 22)
        label.textAlignment = .center
        label.textColor = .white
        label.backgroundColor = UIColor.systemPurple.withAlphaComponent(0.6)
        return label
    }()
    
    lazy var currencyNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.defaultBold(ofSize: 16)
        label.textColor = .black
        return label
    }()
    
    lazy var currencyValueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.defaultRegular(ofSize: 14)
        label.textColor = .black
        return label
    }()
    
    lazy var notificationImageView: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(named: Constants.notificationBellImageName)
        imageView.image = image?.withTintColor(UIColor.systemOrange.withAlphaComponent(0.8))
        return imageView
    }()
    
    lazy var alertValueLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 15
        label.font = UIFont.defaultBold(ofSize: 14)
        label.backgroundColor = UIColor.systemOrange.withAlphaComponent(0.8)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy var dateCreatedLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.defaultRegular(ofSize: 12)
        label.textColor = .lightGray
        return label
    }()
    
    // MARK: UITableViewCell Functions
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        currencyIconLabel.layer.cornerRadius = 20
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
extension AlertCardTableViewCell: CodeView {
    
    func buildViewHierarchy() {
        cardView.addSubview(currencyIconLabel)
        cardView.addSubview(currencyNameLabel)
        cardView.addSubview(dateCreatedLabel)
        cardView.addSubview(alertValueLabel)
        cardView.addSubview(currencyValueLabel)
        cardView.addSubview(notificationImageView)
        addSubview(cardView)
    }
    
    func setupConstraints() {
        cardView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().inset(20)
            make.height.equalTo(90)
            make.centerX.equalToSuperview()
        }
        
        currencyIconLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.width.equalToSuperview().multipliedBy(0.22)
            make.height.equalTo(cardView.snp.width).multipliedBy(0.22)
            make.centerY.equalToSuperview()
        }
        
        currencyNameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(currencyIconLabel.snp.top)
            make.left.equalTo(currencyIconLabel.snp.right).offset(15)
            make.right.equalToSuperview().inset(20)
            make.height.equalTo(28)
        }

        dateCreatedLabel.snp.makeConstraints { (make) in
            make.left.equalTo(currencyIconLabel.snp.right).offset(15)
            make.bottom.equalTo(currencyIconLabel.snp.bottom)
            make.right.equalToSuperview().inset(20)
            make.height.equalTo(28)
        }
        
        currencyValueLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(currencyIconLabel.snp.bottom)
            make.right.equalToSuperview().inset(20)
            make.height.equalTo(28)
        }
        
        alertValueLabel.snp.makeConstraints { (make) in
            make.top.equalTo(currencyIconLabel.snp.top)
            make.right.equalToSuperview().inset(20)
            make.height.equalTo(30)
            make.width.equalToSuperview().multipliedBy(0.25)
        }
        
        notificationImageView.snp.makeConstraints { (make) in
            make.right.equalTo(alertValueLabel.snp.left)
            make.centerY.equalTo(alertValueLabel.snp.centerY)
            make.height.width.equalTo(alertValueLabel.snp.height).multipliedBy(0.8)
        }
    }
    
    func setupAdditionalConfigurarion() {}
}
