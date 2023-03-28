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
    @IBOutlet weak var currentPriceLabel: UILabel! {
        didSet {
            currentPriceLabel.textColor = .blue
        }
    }
    @IBOutlet weak var priceChangedLabel: UILabel!
    @IBOutlet weak var priceChangedPercentageLabel: UILabel!
    @IBOutlet weak var lastUpdateLabel: UILabel! {
        didSet {
            lastUpdateLabel.textColor = .darkGray
        }
    }
    
    private let networkManager = NetworkManager.shared
    var currency: Currency!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = currency.name
        
        currencyImage.layer.cornerRadius = currencyImage.frame.height / 2
        symbolLabel.text = currency.symbol.uppercased()
        currentPriceLabel.text = "\(currency.currentPrice)"
        priceChangedLabel.text = "\(currency.priceChange)"
        priceChangedPercentageLabel.text = "\(currency.priceChangePercentage)"
        lastUpdateLabel.text = "\(currency.lastUpdate)"
        
        fetchImage()
        setColorForPrice()
        setColorForPricePercent()
    }
    
    func setColorForPrice() {
        if currency.priceChange  > 0 {
            priceChangedLabel.textColor = .systemGreen
        } else {
            priceChangedLabel.textColor = .red
        }
    }
    
    func setColorForPricePercent() {
        if currency.priceChangePercentage > 0 {
            priceChangedPercentageLabel.textColor = .systemGreen
        } else {
            priceChangedPercentageLabel.textColor = .red
        }
    }
}

// MARK: - Networking
extension MarketInformationViewController {
    func fetchImage() {
        networkManager.fetchImageData(from: currency.image) { [weak self] result in
            switch result {
            case .success(let imageData):
                self?.currencyImage.image = UIImage(data: imageData)
            case .failure(let error):
                print(error)
            }
        }
    }
}
