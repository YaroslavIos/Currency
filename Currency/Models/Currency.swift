//
//  Currency.swift
//  Currency
//
//  Created by Ярослав Любиченко on 23.3.2023.
//

import Foundation

struct Currency: Codable {
    let id: String
    let name: String
    let currentPrice: Double
    let priceChange: Double
    let priceChangePercentage: Double
    let lastUpdate: String
}

extension Currency {
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case currentPrice = "current_price"
        case priceChange = "price_change_24h"
        case priceChangePercentage = "price_change_percentage_24h"
        case lastUpdate = "last_updated"
    }
}
