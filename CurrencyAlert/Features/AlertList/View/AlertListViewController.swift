//
//  CurrenciesListViewController.swift
//  CurrencyChecker
//
//  Created by Victor Oka on 15/06/20.
//  Copyright © 2020 Victor Oka. All rights reserved.
//

import UIKit

final class AlertListViewController: UIViewController {
    
    private let viewModel: AlertListViewModel
    private var tableViewData: [AlertViewModel]?
    
    // MARK: Screen Components
    private let tableView = UITableView()
    
    // MARK: View Controller Functions
    init(viewModel: AlertListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError(Constants.initFatalErrorDefaultMessage)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupNavigationBar()
        fetchAlerts()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
        setupView()
        setupTableView()
    }
    
    private func setupViewModel() {
        viewModel.delegate = self
    }
    
    private func fetchAlerts() {
        CustomActivityIndicator.shared.showProgressView(on: view)
        viewModel.fetch()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(AlertCardTableViewCell.self, forCellReuseIdentifier: AlertListStrings.cellReuseIdentifier.rawValue)
    }
    
    private func setupNavigationBar() {
        tabBarController?.navigationItem.title = AlertListStrings.navigationBarTitle.rawValue
        tabBarController?.navigationItem.searchController = nil
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.systemPurple]
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.systemPurple, NSAttributedString.Key.font: UIFont.defaultBold(ofSize: 32)]
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
    }
}

// MARK: Alert List View Model Delegate
extension AlertListViewController: AlertListViewModelDelegate {
    
    func fetchAlertsSuccess(alerts: [AlertViewModel]) {
        tableViewData = alerts
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        CustomActivityIndicator.shared.hideProgressView()
    }
    
    func fetchAlertsFailure() {
        CustomActivityIndicator.shared.hideProgressView()
    }
    
}

// MARK: TableViewDelegate Protocol
extension AlertListViewController: UITableViewDelegate {}

// MARK: TableViewDataSource Protocol
extension AlertListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let data = tableViewData?[indexPath.row] else { return UITableViewCell() }
        let cell = tableView.dequeueReusableCell(withIdentifier: AlertListStrings.cellReuseIdentifier.rawValue, for: indexPath) as! AlertCardTableViewCell
        cell.selectionStyle = .none
        cell.currencyNameLabel.text = data.code
        cell.currencyValueLabel.text = "R$ \(data.value)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}

// MARK: Code View Protocol
extension AlertListViewController: CodeView {
    
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
