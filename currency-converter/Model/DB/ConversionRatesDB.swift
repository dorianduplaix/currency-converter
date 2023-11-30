//
//  ConversionRatesDB.swift
//  currency-converter
//
//  Created by Dorian Duplaix on 30/11/2023.
//

import Foundation
import RealmSwift

class ConversionRatesDB: Object {
    @Persisted var timestamp: Date = Date(timeIntervalSince1970: 0)
    @Persisted var base: String
    @Persisted var rates = Map<String, Double>()
    
    convenience init(timestamp: Date, base: String, rates: [String: Double]) {
        self.init()
        self.timestamp = timestamp
        self.base = base
        rates.forEach { (key, value) in
            self.rates[key] = value
        }
    }
    
    convenience init(_ exchange: ConversionRates) {
        self.init()
        self.timestamp = exchange.timestamp
        self.base = exchange.base
        exchange.rates.forEach { (key, value) in
            self.rates[key] = value
        }
    }
}
