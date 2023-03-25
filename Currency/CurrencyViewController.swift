//
//  CurrencyTableViewController.swift
//  Currency
//
//  Created by Ярослав Любиченко on 23.3.2023.
//

import UIKit

class CurrencyViewController: UITableViewController {
    
    private var currencies: [Currency] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 80
        
        fetchCurrency()
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
extension CurrencyViewController {
    
    private func fetchCurrency() {
        URLSession.shared.dataTask(with: Link.currencyURL.url) { [weak self] data, _, error in
            guard let data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }

            do {
                let decoder = JSONDecoder()

                self?.currencies = try decoder.decode([Currency].self, from: data)
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            } catch let error {
                print(error.localizedDescription)
            }
        }.resume()
    }
}
