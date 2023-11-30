//
//  Conversion.swift
//  currency-converter
//
//  Created by Dorian Duplaix on 07/11/2023.
//

import Foundation

struct Conversion: Codable {
    var disclaimer: String
    var license: String
    var request: Query
    var meta: Meta
    var response: Double
}

struct Query: Codable {
    var query: String
    var amount: Double
    var from: String
    var to: String
}

struct Meta: Codable {
    var timestamp: TimeInterval
    var rate: Double
}
