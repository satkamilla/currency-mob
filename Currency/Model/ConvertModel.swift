//
//  ConvertModel.swift
//  Currency
//
//  Created by Kamilla on 17.06.2023.
//

import Foundation

struct ConvertModel: Codable {

    let oldAmount: Int
    let oldCurrency: String
    let newCurrency: String
    let newAmount: Double
    
    
    enum CodingKeys: String, CodingKey {
        case oldAmount = "old_amount"
        case oldCurrency = "old_currency"
        case newCurrency = "new_currency"
        case newAmount = "new_amount"
    }
}
