//
//  CurrencyItemView.swift
//  СurrencyApp
//
//  Created by Kamilla on 17.06.2023.
//

import SwiftUI

struct CurrencyItemView: View {
    
    let currencyQuote: String
    let value: Double
    
    var body: some View {
        HStack {
            Text(currencyQuote)
            
            Spacer()
            
            Text("\(value)")
                .fontWeight(.bold)
        }
        .fontDesign(.rounded)
        .foregroundColor(.accentColor)
        .padding(8)
    }
}

struct CurrencyItemView_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyItemView(currencyQuote: "AED", value: 4.025767)
    }
}
