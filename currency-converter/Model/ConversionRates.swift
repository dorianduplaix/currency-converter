//
//  ConversionRates.swift
//  currency-converter
//
//  Created by Dorian Duplaix on 07/11/2023.
//

import Foundation

public struct ConversionRates: Codable {
    public let disclaimer: String
    public let license: String
    public let timestamp: Date
    public let base: String
    public let rates: [String: Double]
    
    public init(disclaimer: String, license: String, timestamp: Date, base: String, rates: [String : Double]) {
        self.disclaimer = disclaimer
        self.license = license
        self.timestamp = timestamp
        self.base = base
        self.rates = rates
    }
}
