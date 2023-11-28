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
            ContentView(viewModel: ContentViewModel(), service: ExchangeRatesService(request: RequestManager()))
        }
    }
}
