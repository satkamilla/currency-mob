//
//  СurrenciesView.swift
//  СurrencyApp
//
//  Created by Kamilla on 17.06.2023.
//

import SwiftUI

struct СurrenciesView: View {
    
    @State private var searchText = ""
    @State private var showAlert = false
    @StateObject private var viewModel = CurrencyViewModel()
    let defaults = UserDefaults.standard
    
    private var searchResults: [String : Double] {
        if searchText.isEmpty {
            return viewModel.currencies.rates
        } else {
            return viewModel.currencies.rates
                .filter { $0.key.contains(searchText.uppercased()) }
        }
    }
    
    var body: some View {
        VStack {
            if viewModel.currencies.rates.count == 0 {
                ProgressView()
            } else {
                currencies
            }
        }
        .onAppear {
            viewModel.getFromUserDefaults()
            
            Task {
                do {
                    try await viewModel.fetchCurrencies(base: "EUR")
                } catch {
                    showAlert = true
                }
            }
        }
        .alert("Server error! You will see old data", isPresented: $showAlert) {
            Button("OK!") {}
        }
    }
    
    var currencies: some View {
        NavigationView {
            VStack {
                List(Array(searchResults), id: \.key) { data in
                    NavigationLink {
                        DetailCurrencyView(
                            currencyQuote: data.key,
                            value: data.value
                        ) {
                            viewModel.selectedFlag(currency: data.key)
                        }
                    } label: {
                        CurrencyItemView(
                            currencyQuote: data.key,
                            value: data.value
                        )
                    }
                }
                .refreshable {
                    do {
                        try await viewModel.fetchCurrencies(base: "EUR")
                    } catch {
                        showAlert = true
                    }
                }
            }
            .navigationTitle("Currencies")
            .searchable(text: $searchText)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink { ConvertorView() } label: {
                        Image(systemName: "arrow.triangle.2.circlepath")
                    }
                }
            }
        }
    }
}
