//
//  MarketInformationViewController.swift
//  Currency
//
//  Created by Ярослав Любиченко on 25.3.2023.
//

import UIKit

final class MarketInformationViewController: UIViewController {
    
    @IBOutlet weak var currentPriceLabel: UILabel!
    @IBOutlet weak var priceChangedLabel: UILabel!
    @IBOutlet weak var priceChangedPercentageLabel: UILabel!
    @IBOutlet weak var lastUpdateLabel: UILabel!
    
    var currency: Currency!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = currency.name
        currentPriceLabel.text = "Current price: \(currency.currentPrice)"
        priceChangedLabel.text = "Price changed 24H: \(currency.priceChange)"
        priceChangedPercentageLabel.text = "Price changed percentage: \(currency.priceChangePercentage)"
        lastUpdateLabel.text = "Last updated: \(currency.lastUpdate)"
    }
}
