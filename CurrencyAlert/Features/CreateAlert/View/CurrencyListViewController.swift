//
//  CurrencyListViewController.swift
//  CurrencyAlert
//
//  Created by Victor Oka on 07/07/20.
//  Copyright © 2020 Alerta Câmbio. All rights reserved.
//

import UIKit

final class CurrencyListViewController: UIViewController {
    
    private let viewModel: CurrencyListViewModel
    private var tableViewData: [CurrencyViewModel]?
    
    // MARK: Screen Components
    private let tableView = UITableView()
    
    // MARK: View Controller Functions
    init(viewModel: CurrencyListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError(Constants.initFatalErrorDefaultMessage)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupNavigationBar()
        setupTableView()
        setupView()
        fetchCurrencies()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
    }
    
    private func setupViewModel() {
        viewModel.delegate = self
    }
    
    private func fetchCurrencies() {
        CustomActivityIndicator.shared.showProgressView(on: view)
        viewModel.fetch()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .singleLine
        tableView.register(CurrencyTableViewCell.self, forCellReuseIdentifier: CreateAlertStrings.cellReuseIdentifier.rawValue)
    }
    
    private func setupNavigationBar() {
        tabBarController?.navigationItem.title = CreateAlertStrings.navigationBarTitle.rawValue
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.systemPurple]
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.systemPurple, NSAttributedString.Key.font: UIFont.defaultBold(ofSize: 32)]
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
    }
}

// MARK: Currencies List View Model Delegate
extension CurrencyListViewController: CurrencyListViewModelDelegate {
    
    func fetchCurrenciesSuccess(currencies: [CurrencyViewModel]) {
        tableViewData = currencies
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        CustomActivityIndicator.shared.hideProgressView()
    }
    
    func fetchCurrenciesFailure() {
        CustomActivityIndicator.shared.hideProgressView()
    }
    
}

// MARK: TableViewDelegate Protocol
extension CurrencyListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

// MARK: TableViewDataSource Protocol
extension CurrencyListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CreateAlertStrings.cellReuseIdentifier.rawValue, for: indexPath) as! CurrencyTableViewCell
        cell.selectionStyle = .gray
        cell.currencyNameLabel.text = tableViewData?[indexPath.row].name
        cell.currencyValueLabel.text = "R$ \(tableViewData?[indexPath.row].ask ?? "0,00")"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

// MARK: Code View Protocol
extension CurrencyListViewController: CodeView {
    
    func buildViewHierarchy() {
        view.addSubview(tableView)
    }
    
    func setupConstraints() {
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(additionalSafeAreaInsets.bottom)
            make.left.right.bottom.equalToSuperview()
        }
    }
    
    func setupAdditionalConfigurarion() {
        view.backgroundColor = .white
    }
}
