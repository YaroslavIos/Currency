//
//  NetworkManager.swift
//  Currency
//
//  Created by Ярослав Любиченко on 23.3.2023.
//

import Foundation
import Alamofire

enum Link {
    case currencyURL
    
    var url: URL {
        switch self {
        case .currencyURL:
            return URL(string:
                        "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=false")!
        }
    }
}

enum NetworkError: Error {
    case noData
    case decodingError
}

final class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchCurrencies(from url: URL, completion: @escaping(Result<[Currency], AFError>) -> Void) {
        AF.request(url)
            .validate()
            .responseJSON { dataResponse in
                switch dataResponse.result {
                case .success(let value):
                    let currencies = Currency.getCurrency(from: value)
                    completion(.success(currencies))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func fetchImageData(from url: String, completion: @escaping (Result<Data, AFError>) -> Void) {
        AF.request(url)
            .validate()
            .responseData { DataResponse in
                switch DataResponse.result {
                case .success(let imageData):
                    completion(.success(imageData))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
