//
//  CurrencyChoiceView.swift
//  currency-converter
//
//  Created by Dorian Duplaix on 10/11/2023.
//

import SwiftUI

struct CurrencyChoiceView: View {
    @Environment(\.dismiss) var dismiss
    @Binding private var selectedCurrency: String
    private let currencies: Currency
    
    init(currencies: Currency, selectedCurrency: Binding<String>) {
        self.currencies = currencies
        self._selectedCurrency = selectedCurrency
    }

    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    ForEach(currencies.sorted(by: <), id: \.key) { currency in
                        let currencyItem = CurrencyItem(symbol: currency.key, name: currency.value)
                        Item(withValue: false, currencyItem: currencyItem)
                            .onTapGesture {
                                selectedCurrency = currency.key
                                dismiss()
                            }
                    }
                }
                .navigationTitle("Choose a currency")
                .padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0))
            }
            .background(Color.black)
            .opacity(0.9)
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(.visible, for: .navigationBar)
        }
    }
}
