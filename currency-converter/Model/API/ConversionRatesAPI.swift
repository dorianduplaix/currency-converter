//
//  ConversionRatesAPI.swift
//  currency-converter
//
//  Created by Dorian Duplaix on 07/11/2023.
//

import Foundation

struct ConversionRatesAPI: Codable {
    var timestamp: Date
    var base: String
    var rates: [String: Double]
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let timeInterval = try container.decode(Double.self, forKey: .timestamp)
        timestamp = Date(timeIntervalSince1970: timeInterval)
        base = try container.decode(String.self, forKey: .base)
        rates = try container.decode([String: Double].self, forKey: .rates)
    }
}
