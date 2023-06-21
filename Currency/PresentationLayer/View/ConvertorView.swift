//
//  ConvertorView.swift
//  Currency
//
//  Created by Kamilla on 17.06.2023.
//

import SwiftUI

struct ConvertorView: View {
    
    @StateObject private var viewModel = CurrencyViewModel()
    
    var body: some View {
        VStack {
            VStack(spacing: 16) {
                TextField("Enter...", text: $viewModel.fromCurrency, prompt: Text("From currency"))
                
                TextField("Enter...", text: $viewModel.toCurrency, prompt: Text("From currency"))
                
                TextField("Enter...", text: $viewModel.amount, prompt: Text("Amount"))
                    .keyboardType(.decimalPad)
            }
            .textFieldStyle(CustomTextFieldStyle())
            
            Spacer()
            
            Text("Result: \(String(format: "%.2f", viewModel.currencyResult))")
                .font(.title2)
                .fontDesign(.rounded)
            
            Spacer()
            
            Button {
                Task {
                    try await viewModel.convertCurrencies()
                }
            } label: {
                Text("Convert!")
                    .padding()
                    .background(Color.accentColor)
                    .foregroundColor(.white)
                    .cornerRadius(20)
            }

        }
        .padding(.top)
        .navigationTitle("Convertor")
    }
}
