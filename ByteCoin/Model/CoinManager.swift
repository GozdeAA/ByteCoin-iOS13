//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate {
    func didFailWithError(error: Error?)
    func didCoinUpdate(coinData: CoinData, _ coinManager: CoinManager)
}

struct CoinManager {
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "74AB4405-26C1-44E4-8583-2443DED274A1"
    let currencyArray = ["AUD", "BRL", "CAD", "CNY", "EUR", "GBP", "HKD", "IDR", "ILS", "INR", "JPY", "MXN", "NOK", "NZD", "PLN", "RON", "RUB", "SEK", "SGD", "USD", "ZAR"]

    var delegate: CoinManagerDelegate?

    func getCoinPrice(for currency: String) -> String {
        let urlString = "\(baseURL)/\(currency)?apikey=\(apiKey)"
        return urlString
    }

    func performRequest(urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            var urlRequest = URLRequest(url: url)
            urlRequest.setValue(apiKey, forHTTPHeaderField: "X-CoinAPI-Key")

            let task = session.dataTask(with: urlRequest) { Data, _, error in
                if error != nil {
                    delegate?.didFailWithError(error: error)
                }
                if let data = Data {
                    let json = parseJson(data: data)
                    if let safeJson = json { // if json is not nil
                        delegate?.didCoinUpdate(coinData: safeJson, self)
                    }
                }
            }
            task.resume()
        }
    }

    func parseJson(data: Data) -> CoinData? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CoinData.self, from: data) // given data must be decodable (or codable)

            /*          MARK: copyable example
                        https://www.hackingwithswift.com/example-code/system/how-to-copy-objects-in-swift-using-copy
                        let rate = String(format: "%2f", decodedData.rate)

                        let newData = decodedData.copy() as! CoinData
                        newData.rate = rate
             */

            return decodedData
        } catch {
            print(error)
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
