//
//  MarketInformationViewController.swift
//  Currency
//
//  Created by Ярослав Любиченко on 25.3.2023.
//

import UIKit

final class MarketInformationViewController: UIViewController {
    
    @IBOutlet weak var currencyImage: UIImageView!
    
    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var currentPriceLabel: UILabel!
    @IBOutlet weak var priceChangedLabel: UILabel!
    @IBOutlet weak var priceChangedPercentageLabel: UILabel!
    @IBOutlet weak var lastUpdateLabel: UILabel!
    
    private let networkManager = NetworkManager.shared
    var currency: Currency!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = currency.name
        
        currencyImage.layer.cornerRadius = currencyImage.frame.height / 2
        symbolLabel.text = currency.symbol.uppercased()
        currentPriceLabel.text = "Current price: \(currency.currentPrice)"
        priceChangedLabel.text = "Price changed 24H: \(currency.priceChange)"
        priceChangedPercentageLabel.text = "Price changed percentage: \(currency.priceChangePercentage)"
        lastUpdateLabel.text = "Last updated: \(currency.lastUpdate)"
        
        fetchCurrencyImage()
    }
}

// MARK:- Networking
extension MarketInformationViewController {
    func fetchCurrencyImage() {
        networkManager.fetchImage(from: currency.image) { [weak self] result in
            switch result {
            case .success(let imageData):
                self?.currencyImage.image = UIImage(data: imageData)
            case .failure(let error):
                print(error)
            }
        }
    }
}
