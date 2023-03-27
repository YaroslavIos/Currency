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
    
// MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = tableView.indexPathForSelectedRow {
            guard let marketVC = segue.destination as? MarketInformationViewController else { return }
            marketVC.currency = currencies[indexPath.row]
        }
    }
}

//MARK: - Networking
//extension CurrencyViewController {
//
//    private func fetchCurrency() {
//        networkManager.fetch([Currency].self, from: Link.currencyURL.url) { [weak self] result in
//            switch result {
//            case .success(let currencies):
//                self?.currencies = currencies
//                self?.tableView.reloadData()
//            case .failure(let error):
//                print(error)
//            }
//        }
//    }
//}
