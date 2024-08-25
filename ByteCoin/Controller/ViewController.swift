//
//  ViewController.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var currency: UILabel!
    @IBOutlet var picker: UIPickerView!
    @IBOutlet var value: UILabel!
    var coinManager = CoinManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        picker.dataSource = self
        picker.delegate = self
        coinManager.delegate = self
        // Do any additional setup after loading the view.
    }
}

extension ViewController: CoinManagerDelegate {
    func didCoinUpdate(coinData: CoinData, _ coinManager: CoinManager) {
        DispatchQueue.main.async { // << Clousure -- this process might take a long time
            self.currency.text = String(format: "%.2f", coinData.rate)
        }
    }

    func didFailWithError(error: (any Error)?) {
        if let newError = error {
            print(newError)
        }
    }
}

extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selected = coinManager.currencyArray[row]
        print(selected)
        let url = coinManager.getCoinPrice(for: selected)
        coinManager.performRequest(urlString: url)
    }
}
