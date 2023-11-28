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
    @State private var searchText = ""
    private let currencies: Currencies
    
    init(currencies: Currencies, selectedCurrency: Binding<String>) {
        self.currencies = currencies
        self._selectedCurrency = selectedCurrency
    }

    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    ForEach(currencies.sorted(by: <), id: \.key) { currency in
                        item(currencySymbol: currency.key)
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
    
    @ViewBuilder 
    private func item(currencySymbol: String) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 14)
                .fill(.gray)
                .opacity(0.4)
                .frame(height: 60)
                .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
            HStack {
                VStack(spacing: 7) {
                    Text(currencySymbol)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(Font.headline.weight(.heavy))
                    Text(currencies[currencySymbol] ?? "-")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.system(size: 12))
                }
                .foregroundColor(.white)
                .padding(EdgeInsets(top: 0, leading: 30, bottom: 0, trailing: 30))
                Image("arrow-right-bold")
                    .resizable()
                    .renderingMode(.template)
                    .foregroundColor(.white)
                    .frame(width: 14, height: 14, alignment: .trailing)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 30))
            }
        }
    }
}

#Preview {
    CurrencyChoiceView(currencies: ["Toto":"Toto", "Toti":"Toto"], selectedCurrency: .constant("USD"))
}
