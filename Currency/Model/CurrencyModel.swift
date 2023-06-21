//
//  CurrencyModel.swift
//  СurrencyApp
//
//  Created by Kamilla on 17.06.2023.
//

import Foundation

struct CurrencyModel: Codable {
    let success: Bool
    let timestamp: Int
    let base, date: String
    var rates: [String: Double]
    
    init(success: Bool, timestamp: Int, base: String, date: String, rates: [String : Double]) {
        self.success = success
        self.timestamp = timestamp
        self.base = base
        self.date = date
        self.rates = rates
    }
    
    init() {
        self.success = false
        self.timestamp = 0
        self.base = ""
        self.date = ""
        self.rates = [:]
    }

}
