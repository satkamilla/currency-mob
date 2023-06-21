//
//  TextFieldStyle.swift
//  Currency
//
//  Created by Kamilla on 17.06.2023.
//

import SwiftUI

struct CustomTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(12)
            .background(.gray.opacity(0.15))
            .cornerRadius(15)
            .padding(.horizontal, 16)
    }
}
