//
//  CurrenciesListViewController.swift
//  CurrencyChecker
//
//  Created by Victor Oka on 15/06/20.
//  Copyright © 2020 Victor Oka. All rights reserved.
//

import UIKit

final class CurrenciesListViewController: UIViewController {
    
    private let viewModel: CurrenciesListViewModel
    private var tableViewData: [CurrencyViewModel]?
    
    // MARK: Screen Components
    private let tableView = UITableView()
    
    // MARK: View Controller Functions
    init(viewModel: CurrenciesListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError(Constants.initFatalErrorDefaultMessage)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.ready()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupTableView()
        setupView()
        setupViewModel()
    }
    
    private func setupViewModel() {
        viewModel.isRefreshing = { loading in
            // TODO: Implement activity indicator
            // UIApplication.shared.isNetworkActivityIndicatorVisible = loading
        }
        
        viewModel.didUpdateCurrencies = { [weak self] currencies in
            guard let strongSelf = self else { return }
            strongSelf.tableViewData = currencies
            DispatchQueue.main.async {
                strongSelf.tableView.reloadData()
            }
        }
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(CurrencyCardTableViewCell.self, forCellReuseIdentifier: CurrenciesListStrings.cellReuseIdentifier.rawValue)
    }
    
    private func setupNavigationBar() {
        navigationItem.title = CurrenciesListStrings.navigationBarTitle.rawValue
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.systemPurple]
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.systemPurple, NSAttributedString.Key.font: UIFont.defaultBold(ofSize: 32)]
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
    }
}

// MARK: TableViewDelegate Protocol
extension CurrenciesListViewController: UITableViewDelegate {}

// MARK: TableViewDataSource Protocol
extension CurrenciesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CurrenciesListStrings.cellReuseIdentifier.rawValue, for: indexPath) as! CurrencyCardTableViewCell
        cell.selectionStyle = .none
        cell.currencyNameLabel.text = tableViewData?[indexPath.row].name
        cell.currencyValueLabel.text = tableViewData?[indexPath.row].ask
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}

// MARK: Code View Protocol
extension CurrenciesListViewController: CodeView {
    
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
