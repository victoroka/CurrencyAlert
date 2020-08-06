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
    private var filteredCurrencies = [CurrencyViewModel]()
    private let tableViewRowHeight: CGFloat = 60
    
    var isFiltering: Bool {
        return searchController.isActive && !isSearchBarEmpty()
    }
    
    // MARK: Screen Components
    private let tableView = UITableView()
    
    lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = CreateAlertStrings.searchBarPlaceholder.rawValue
        searchController.searchBar.sizeToFit()
        searchController.searchBar.searchBarStyle = .prominent
        return searchController
    }()
    
    // MARK: View Controller Functions
    init(viewModel: CurrencyListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError(Constants.initFatalErrorDefaultMessage)
    }
    
    // MARK: View Controller Functions
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
        view.backgroundColor = .white
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
        tabBarController?.navigationItem.searchController = searchController
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.systemPurple]
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.systemPurple, NSAttributedString.Key.font: UIFont.defaultBold(ofSize: 32)]
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
    }
    
    private func filterContentFor(searchText: String) {
        guard let currencies = tableViewData else { return }
        filteredCurrencies = currencies.filter({ (currency: CurrencyViewModel) -> Bool in
            return currency.name.lowercased().contains(searchText.lowercased())
        })
        tableView.reloadData()
    }
    
    private func isSearchBarEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
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
        guard let data = tableViewData else { return }
        let viewModel = CreateAlertPopupViewModel(networkingService: NetworkingAPI())
        let popupView = CreateAlertPopupView(code: data[indexPath.row].code, currentValue: data[indexPath.row].ask, name: data[indexPath.row].name, viewModel: viewModel, frame: view.frame)
        view.addSubview(popupView)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let animation: TableAnimation = .moveUpWithFade(rowHeight: tableViewRowHeight, duration: 0.85, delay: 0.05)
        let animator = TableViewAnimator(animation: animation.getAnimation())
        animator.animate(cell: cell, at: indexPath, in: tableView)
    }
}

// MARK: TableViewDataSource Protocol
extension CurrencyListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredCurrencies.count
        }
        return tableViewData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let data = tableViewData else { return UITableViewCell() }
        let cell = tableView.dequeueReusableCell(withIdentifier: CreateAlertStrings.cellReuseIdentifier.rawValue, for: indexPath) as! CurrencyTableViewCell
        cell.selectionStyle = .gray
        
        let currencyViewModel: CurrencyViewModel
        if isFiltering {
            currencyViewModel = filteredCurrencies[indexPath.row]
        } else {
            currencyViewModel = data[indexPath.row]
        }
        
        cell.iconLabel.text = Utils.setupIconFor(currency: currencyViewModel.name)
        cell.nameLabel.text = currencyViewModel.name
        cell.valueLabel.text = "R$ \(currencyViewModel.ask)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableViewRowHeight
    }
}

// MARK: Search Results Updating Protocol
extension CurrencyListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterContentFor(searchText: searchBar.text!)
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
    
    func setupAdditionalConfigurarion() {}
}
