//
//  ConversionRates.swift
//  currency-converter
//
//  Created by Dorian Duplaix on 30/11/2023.
//

import Foundation
import RealmSwift

struct ConversionRates: Codable, Model, Equatable {
    var timestamp: Date
    var base: String
    var rates: [String: Double]
    
    public init(_ apiModel: ConversionRatesAPI) {
        self.base = apiModel.base
        self.timestamp = Date()
        self.rates = apiModel.rates
    }
    
    public init(_ dbModel: ConversionRatesDB) {
        self.base = dbModel.base
        self.timestamp = dbModel.timestamp
        self.rates = Dictionary<String, Double>()
        zip(dbModel.rates.keys, dbModel.rates.values).forEach { (key, value) in
            self.rates[key] = value
        }
    }
    
    func toDataBaseObject() -> Object {
        return ConversionRatesDB(timestamp: self.timestamp, base: self.base, rates: self.rates)
    }
}
