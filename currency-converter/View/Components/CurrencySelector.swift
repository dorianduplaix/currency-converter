//
//  CurrencySelector.swift
//  currency-converter
//
//  Created by Dorian Duplaix on 30/12/2023.
//

import SwiftUI

struct CurrencySelector: View {
    var selectedCurrency: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 14)
                .fill(.gray)
                .opacity(0.4)
                .frame(height: 30)
            HStack {
                Text(selectedCurrency)
                    .font(Font.headline.weight(.heavy))
                    .foregroundColor(.white)
                Image("arrow-down-bold")
                    .resizable()
                    .renderingMode(.template)
                    .foregroundColor(.white)
                    .frame(width: 14, height: 14, alignment: .trailing)
            }
            .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 10))
        }
        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 30))
    }
}

#Preview {
    CurrencySelector(selectedCurrency: "USD")
}
