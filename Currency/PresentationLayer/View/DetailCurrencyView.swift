//
//  DetailCurrencyView.swift
//  СurrencyApp
//
//  Created by Kamilla on 17.06.2023.
//

import SwiftUI
import Kingfisher

struct DetailCurrencyView: View {
    
    let currencyQuote: String
    let value: Double
    let flagURL: () -> (URL?)
    
    var body: some View {
        VStack {
            
            if let flagURL = flagURL() {
                KFImage(flagURL)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 100)
            }
            
            Text(currencyQuote)
                .font(.title2)
                .fontWeight(.semibold)
            
            Text("\(value)")
            
        }
        .foregroundColor(.accentColor)
        .fontDesign(.rounded)
    }
}
