//
//  CurrencyTableViewCell.swift
//  CurrencyAlert
//
//  Created by Victor Oka on 14/07/20.
//  Copyright © 2020 Alerta Câmbio. All rights reserved.
//

import UIKit

final class CurrencyTableViewCell: UITableViewCell {

    // MARK: Cell Components
    private var labelStack: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .horizontal
        stackView.alignment = .trailing
        stackView.spacing = 15
        stackView.distribution = .fill
        return stackView
    }()
    
    lazy var iconLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.defaultRegular(ofSize: 22)
        label.tintColor = .black
        label.textAlignment = .center
        return label
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.defaultBold(ofSize: 16)
        label.tintColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    lazy var valueLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.defaultRegular(ofSize: 16)
        label.tintColor = .black
        label.textAlignment = .right
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
        labelStack.addArrangedSubview(iconLabel)
        labelStack.addArrangedSubview(nameLabel)
        labelStack.addArrangedSubview(valueLabel)
        addSubview(labelStack)
    }
    
    func setupConstraints() {
        labelStack.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().inset(20)
        }
        
        iconLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.15)
        }
        
        nameLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.40)
        }
        
        valueLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
        }
    }
    
    func setupAdditionalConfigurarion() {}
    
}
