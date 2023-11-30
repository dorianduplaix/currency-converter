//
//  currency_converterApp.swift
//  currency-converter
//
//  Created by Dorian Duplaix on 06/11/2023.
//

import SwiftUI

@main
struct currency_converterApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(conversionService: ConversionService(DefaultStorage(), request: RequestManager(OpenExchangeRatesUrl.latest(base: "USD"))),
                        currencyService: CurrencyService(DefaultStorage(), request: RequestManager(OpenExchangeRatesUrl.currencies)))
        }
    }
}
