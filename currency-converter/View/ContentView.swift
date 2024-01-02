//
//  ContentView.swift
//  currency-converter
//
//  Created by Dorian Duplaix on 06/11/2023.
//

import SwiftUI
import Combine

struct ContentView: View {
    @State private var selectedCurrency = "USD"
    @State private var inputValue: Double = 100.0
    @ObservedObject private var conversionService: ConversionService
    @ObservedObject private var currencyService: CurrencyService
    private var viewModel = ContentViewModel()
    
    public init(conversionService: ConversionService, currencyService: CurrencyService) {
        self.conversionService = conversionService
        self.currencyService = currencyService
    }
    
    var body: some View {
        NavigationView {
            content
                .onAppear {
                    load()
                }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    // Seems like logic inside the View but it is how to manage the view depending on their state
    @ViewBuilder
    private var content: some View {
        switch conversionService.conversionData {
            case .isLoading(let last, _):
                if let lastValue = last, let currencies = currencyService.currenciesData.value {
                    converterMainView(lastValue, currencies)
                } else {
                    LoadingView()
                }
            case .loaded(let last):
                if let currencies = currencyService.currenciesData.value {
                    converterMainView(last, currencies)
                } else {
                    LoadingView()
                }
            case .failed(let error):
                ErrorView(action: load, error: error)
            default:
                LoadingView()
        }
    }
    
    @ViewBuilder
    private func converterMainView(_ rates: ConversionRates, _ currencies: Currency) -> some View {
        ScrollView {
            VStack {
                VStack(spacing: 20) {
                    CurrencyTextfield(currencies: currencies, selectedCurrency: $selectedCurrency, inputValue: $inputValue)
                }
                Divider()
                    .background(Color.white)
                    .padding(EdgeInsets(top: 15, leading: 20, bottom: 10, trailing: 20))
                ForEach(currencies.sorted(by: <), id: \.key) { currency in
                    let currencyValue = viewModel.calculate(amount: inputValue,
                                                            selectedCurrency: selectedCurrency,
                                                            conversionRates: rates,
                                                            currencyToConvert: currency.key)
                    let currencyItem = CurrencyItem(symbol: currency.key, name: currency.value, value: currencyValue)
                    Item(withValue: true, currencyItem: currencyItem)
                }
            }
            .navigationTitle("Currency converter")
            .padding(EdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 0))
        }
        .background(Color.black)
        .opacity(0.9)
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(.visible, for: .navigationBar)
    }
    
    private func load() {
        Task {
            await conversionService.loadIfNeeded()
            await currencyService.loadIfNeeded()
        }
    }
}

// Only logic here
class ContentViewModel: ObservableObject {
    func calculate(amount: Double, selectedCurrency: String, conversionRates: ConversionRates, currencyToConvert: String) -> String {
        guard let conversion = conversionRates.rates[selectedCurrency] else {
            return "-"
        }
        let intoUSD = amount / conversion
        let convertedAmount = intoUSD * (conversionRates.rates[currencyToConvert] ?? 0)
        return convertedAmount.formatted(.currency(code: currencyToConvert))
    }
}
