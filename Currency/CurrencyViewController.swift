//
//  CurrencyTableViewController.swift
//  Currency
//
//  Created by Ярослав Любиченко on 23.3.2023.
//

import UIKit

class CurrencyViewController: UITableViewController {
    
    private let networkManager = NetworkManager.shared
    private var currencies: [Currency] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 80
        
        fetchHandlingCurrency()
        downloadData()
        setupRefreshControl()
    }
    
    private func fetchHandlingCurrency() {
        networkManager.fetchCurrencies(from: Link.currencyURL.url) { [weak self] result in
            switch result {
            case .success(let currencies):
                self?.currencies = currencies
                self?.tableView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = tableView.indexPathForSelectedRow {
            guard let marketVC = segue.destination as? MarketInformationViewController else { return }
            marketVC.currency = currencies[indexPath.row]
        }
    }
}

// MARK: - UITableViewDataSource
extension CurrencyViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        currencies.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "currencyCell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        let currency = currencies[indexPath.row]
        content.text = currency.name
        content.secondaryText = currency.id
        cell.contentConfiguration = content
        return cell
    }
}

// MARK: - Private Methods
extension CurrencyViewController {
    private func downloadData() {
        networkManager.fetchCurrencies(from: Link.currencyURL.url) { [weak self] result in
            switch result {
            case .success(let currencies):
                self?.currencies = currencies
                self?.tableView.reloadData()
                if self?.refreshControl != nil {
                    self?.refreshControl?.endRefreshing()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func setupRefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl?.attributedTitle = NSAttributedString(string: "Pull to refresh")
//        refreshControl?.addTarget(self, action: #selector(downloadData), for: .valueChanged)
        let refreshAction = UIAction { [weak self] _ in
            self?.downloadData()
        }
        refreshControl?.addAction(refreshAction, for: .valueChanged)
    }
}
