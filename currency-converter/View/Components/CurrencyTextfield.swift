//
//  CurrencyTextfield.swift
//  currency-converter
//
//  Created by Dorian Duplaix on 30/12/2023.
//

import SwiftUI

struct CurrencyTextfield: View {
    var currencies: Currency
    @Binding var selectedCurrency: String
    @Binding var inputValue: Double
    @FocusState private var isFocused: Bool
    @State private var showingSheet = false
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .strokeBorder(Color.gray, lineWidth: 1)
                .padding(EdgeInsets(top: -10, leading: 20, bottom: -10, trailing: 20))
            HStack {
                TextField("Enter an amount", value: $inputValue, formatter: NumberFormatter.twoDecimals)
                    .focused($isFocused)
                    .textFieldStyle(PlainTextFieldStyle())
                    .font(Font.headline.weight(.heavy))
                    .multilineTextAlignment(.leading)
                    .keyboardType(.numberPad)
                    .foregroundColor(.white)
                    .padding(EdgeInsets(top: 0, leading: 30, bottom: 0, trailing: 20))
                    .toolbar {
                        ToolbarItemGroup(placement: .keyboard){
                            HStack {
                                EmptyView()
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                Button("Done") {
                                    isFocused = false
                                }
                                .frame(maxWidth: .infinity, alignment: .trailing)
                                .foregroundColor(.primary)
                            }
                        }
                    }
                Spacer()
                CurrencySelector(selectedCurrency: selectedCurrency)
                    .onTapGesture(perform: {
                        showingSheet.toggle()
                    })
                    .sheet(isPresented: $showingSheet) {
                        CurrencyChoiceView(currencies: currencies, selectedCurrency: $selectedCurrency)
                    }
            }
        }
    }
}

#Preview {
    CurrencyTextfield(currencies: [:], selectedCurrency: .constant("USD"), inputValue: .constant(100.00))
}
