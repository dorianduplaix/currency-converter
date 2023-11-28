//
//  Conversion.swift
//  currency-converter
//
//  Created by Dorian Duplaix on 07/11/2023.
//

import Foundation

public struct Conversion: Codable {
    public let disclaimer: String
    public let license: String
    public let request: Query
    public let meta: Meta
    public let response: Double
}

public struct Query: Codable {
    public let query: String
    public let amount: Double
    public let from: String
    public let to: String
}

public struct Meta: Codable {
    public let timestamp: TimeInterval
    public let rate: Double
}
