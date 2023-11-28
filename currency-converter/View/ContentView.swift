//
//  ContentView.swift
//  currency-converter
//
//  Created by Dorian Duplaix on 06/11/2023.
//

import SwiftUI
import Combine

struct ContentView: View {
    @StateObject private var viewModel: ContentViewModel
    @State private var showingSheet = false
    @State private var selectedCurrency = "USD"
    @State private var inputValue: Double = 100.0
    @FocusState private var isFocused: Bool
    @ObservedObject var exchangeRatesService: ExchangeRatesService
    
    public init(viewModel: ContentViewModel, service: ExchangeRatesService) {
        _viewModel = StateObject(wrappedValue: viewModel)
        isFocused = false
        self.exchangeRatesService = service
    }
    
    var body: some View {
        NavigationView {
            content
                .onAppear {
                    viewModel.getConversions()
                    viewModel.getCurrencies()
                }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    @ViewBuilder 
    private var content: some View {
        switch exchangeRatesService.conversionData {
            case .isLoading(let last, let cancelBag):
                if let lastValue = last {
                    converterMainView
                } else {
                    LoadingView()
                }
            case .loaded(let value):
                converterMainView(value)
            case .failed(let error):
                errorView(error)
            default:
                LoadingView()
        }
    }
    
    @ViewBuilder
    private func converterMainView(_ rates: ConversionRates): some View {
        ScrollView {
            VStack {
                VStack(spacing: 20) {
                    textField
                }
                Divider()
                    .background(Color.white)
                    .padding(EdgeInsets(top: 15, leading: 20, bottom: 10, trailing: 20))
                ForEach(viewModel.currencies.sorted(by: <), id: \.key) { currency in
                    item(currencySymbol: currency.key)
                }
            }
            .navigationTitle("Currency converter")
            .onAppear {
                reload()
            }
            .padding(EdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 0))
        }
        .background(Color.black)
        .opacity(0.9)
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(.visible, for: .navigationBar)
    }
    
    @ViewBuilder
    private var textField: some View {
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
                currencySelector
                    .onTapGesture(perform: {
                        showingSheet.toggle()
                    })
                    .sheet(isPresented: $showingSheet) {
                        CurrencyChoiceView(currencies: viewModel.currencies, selectedCurrency: $selectedCurrency)
                    }
            }
        }
    }
    
    @ViewBuilder
    private var currencySelector: some View {
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
                    Text(viewModel.currencies[currencySymbol] ?? "-")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.system(size: 12))
                }
                .foregroundColor(.white)
                .padding(EdgeInsets(top: 0, leading: 30, bottom: 0, trailing: 0))
                Text(viewModel.calculate(amount: inputValue,
                                                  selectedCurrency: selectedCurrency,
                                                  currencyToConvert: currencySymbol))
                    .frame(alignment: .trailing)
                    .font(Font.headline.weight(.heavy))
                    .foregroundColor(.white)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 30))
            }
        }
    }
    
    private func errorView(_ error: Error) -> some View {
        ErrorView(action: reload, error: error)
    }
    
    private func reload() {
        Task {
            await exchangeRatesService.getConversions
            await exchangeRatesService.getCurrencies
        }
    }
}

class ContentViewModel: ObservableObject {
    @Published var conversionRates: ConversionRates?
    @Published var currencies: Currencies = [:]
    private var cancellables = Set<AnyCancellable>()
    
    func calculate(amount: Double, selectedCurrency: String, currencyToConvert: String) -> String {
        guard let conversionRates else {
            return "-"
        }
        let intoUSD = (amount / (conversionRates.rates[selectedCurrency] ?? 0))
        let convertedAmount = intoUSD * (conversionRates.rates[currencyToConvert] ?? 0)
        return convertedAmount.formatted(.currency(code: currencyToConvert))
    }
}
