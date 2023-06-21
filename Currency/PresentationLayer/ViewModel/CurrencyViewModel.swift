//
//  CurrencyViewModel.swift
//  СurrencyApp
//
//  Created by Kamilla on 17.06.2023.
//

import Foundation

@MainActor final class CurrencyViewModel: ObservableObject {
    
    @Published var currencies: CurrencyModel = CurrencyModel()
    @Published var fromCurrency: String = ""
    @Published var toCurrency: String = ""
    @Published var amount: String = ""
    @Published var currencyResult: Double = 0
    
    private let defaults = UserDefaults.standard
    private let apiKey = "4350738995c826559f5b54d2d8f48f5e"
    
    
    func fetchCurrencies(base: String) async throws {
        
        var url: String {
            "http://data.fixer.io/api/latest?access_key=\(apiKey)&base=\(base)"
        }
        
        guard let url = URL(string: url) else {
            fatalError("Missing URL")
        }
        
        let urlRequest = URLRequest(url: url)
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            fatalError("Error while fetching data")
        }
        
        let currencies = try JSONDecoder().decode(CurrencyModel.self, from: data)
        
        self.currencies = currencies
        self.saveToUserDefaults()
        
    }
    
    func convertCurrencies() async throws {
        var url: String {
            "https://api.api-ninjas.com/v1/convertcurrency?have=\(fromCurrency.uppercased())&want=\(toCurrency.uppercased())&amount=\(amount)"
        }
        
        guard let url = URL(string: url) else {
            fatalError("Missing URL")
        }
        
        let urlRequest = URLRequest(url: url)
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            fatalError("Error while fetching data")
        }
        
        let result = try JSONDecoder().decode(ConvertModel.self, from: data)
        
        self.currencyResult = result.newAmount
    }
    
    func selectedFlag(currency: String) -> URL? {
        return URL(string: "https://flagsapi.com/\(currency.dropLast(1))/flat/64.png")
    }
    
    func getFromUserDefaults() {
        if let currencies = defaults.object(forKey: "currencies") as? Data {
            let decoder = JSONDecoder()
            if let loadedCurrencies = try? decoder.decode(CurrencyModel.self, from: currencies) {
                self.currencies = loadedCurrencies
            }
        }
    }
    
    private func saveToUserDefaults() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(currencies) {
            defaults.set(encoded, forKey: "currencies")
        }
    }
}
