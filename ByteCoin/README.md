# README

<!--@START_MENU_TOKEN@-->Summary<!--@END_MENU_TOKEN@-->

## Copyable class example


https://www.hackingwithswift.com/example-code/system/how-to-copy-objects-in-swift-using-copy
```
let rate = String(format: "%2f", decodedData.rate)
let newData = decodedData.copy() as! CoinData
newData.rate = rate
```

### class 
```
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
        case assetIDBase
        case assetIDQuote
        case rate
    }
}
```


