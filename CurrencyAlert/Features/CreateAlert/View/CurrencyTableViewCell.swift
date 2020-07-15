//
//  CurrencyTableViewCell.swift
//  CurrencyAlert
//
//  Created by Victor Oka on 14/07/20.
//  Copyright © 2020 Alerta Câmbio. All rights reserved.
//

import UIKit

class CurrencyTableViewCell: UITableViewCell {

    // MARK: Cell Components
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
        setupView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}

extension CurrencyTableViewCell: CodeView {
    func buildViewHierarchy() {
        addSubview(currencyNameLabel)
        addSubview(currencyValueLabel)
    }
    
    func setupConstraints() {
        currencyNameLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(40)
            make.height.equalTo(28)
        }
        
        currencyValueLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.right.equalToSuperview().inset(40)
            make.height.equalTo(28)
        }
    }
    
    func setupAdditionalConfigurarion() {}
    
}
