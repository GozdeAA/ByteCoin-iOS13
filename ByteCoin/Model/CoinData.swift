//
//  CoinData.swift
//  ByteCoin
//
//  Created by Gözde Aydin on 23.08.2024.
//  Copyright © 2024 The App Brewery. All rights reserved.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let coinData = try? JSONDecoder().decode(CoinData.self, from: jsonData)

import Foundation

// MARK: - CoinData

class CoinData: Codable, NSCopying {
    func copy(with zone: NSZone? = nil) -> Any {
        return CoinData(time: time, assetIDBase: assetIDBase, assetIDQuote: assetIDQuote, rate: rate)
    }

    init(time: String, assetIDBase: String, assetIDQuote: String, rate: Double) {
        self.time = time
        self.assetIDBase = assetIDBase
        self.assetIDQuote = assetIDQuote
        self.rate = rate
    }

    var time, assetIDBase, assetIDQuote: String
    var rate: Double

    enum CodingKeys: String, CodingKey {
        case time
        case assetIDBase = "asset_id_base"
        case assetIDQuote = "asset_id_quote"
        case rate
    }
}
