//
//  ConversionMock.swift
//  currency-converter
//
//  Created by Dorian Duplaix on 07/11/2023.
//

import Foundation

let conversionMock = """
{
  "disclaimer": "https://openexchangerates.org/terms/",
  "license": "https://openexchangerates.org/license/",
  "request": {
    "query": "/convert/19999.95/GBP/EUR",
    "amount": 19999.95,
    "from": "GBP",
    "to": "EUR"
  },
  "meta": {
    "timestamp": 1449885661,
    "rate": 1.383702
  },
  "response": 27673.975864
}
""".data(using: .utf8)

open class DecoderMock {
    private var decoder = JSONDecoder()
    func getConversionMock() -> Conversion {
        let conversion = try! self.decoder.decode(Conversion.self, from: conversionMock!)
        return conversion
    }
}
