//
//  Currency.swift
//  Currency
//
//  Created by Ярослав Любиченко on 23.3.2023.
//

import Foundation

struct Currency: Codable {
    let id: String
    let symbol: String
    let name: String
    let image: String
    let currentPrice: Double
    let priceChange: Double
    let priceChangePercentage: Double
    let lastUpdate: String
    
    init(id: String,
         symbol: String,
         name: String,
         image: String,
         currentPrice: Double,
         priceChange: Double,
         priceChangePercentage: Double,
         lastUpdate: String
    ) {
        self.id = id
        self.symbol = symbol
        self.name = name
        self.image = image
        self.currentPrice = currentPrice
        self.priceChange = priceChange
        self.priceChangePercentage = priceChangePercentage
        self.lastUpdate = lastUpdate
    }
    
    init(currencyDatum: [String: Any]) {
    id = currencyDatum["id"] as? String ?? ""
    symbol = currencyDatum["symbol"] as? String ?? ""
    name = currencyDatum["name"] as? String ?? ""
    image = currencyDatum["image"] as? String ?? ""
    currentPrice = currencyDatum["current_price"] as? Double ?? 0
    priceChange = currencyDatum["price_change_24h"] as? Double ?? 0
    priceChangePercentage = currencyDatum["price_change_percentage_24h"] as? Double ?? 0
    lastUpdate = currencyDatum["last_updated"] as? String ?? ""
    }
    
    static func getCurrency(from value: Any) -> [Currency] {
        guard let currencyData = value as? [[String: Any]] else { return [] }
        return currencyData.map { Currency(currencyDatum: $0)}
    }
}

extension Currency {
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case symbol = "symbol"
        case name = "name"
        case image = "image"
        case currentPrice = "current_price"
        case priceChange = "price_change_24h"
        case priceChangePercentage = "price_change_percentage_24h"
        case lastUpdate = "last_updated"
    }
}
