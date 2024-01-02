//
//  ContentViewModelTests.swift
//  currency-converterTests
//
//  Created by Dorian Duplaix on 30/12/2023.
//

import XCTest
import SwiftUI
@testable import currency_converter

final class ContentViewModelTests: XCTestCase {
    private var decoder = JSONDecoder()
    
    func testCalculate() {
        let conversion = try! self.decoder.decode(ConversionRates.self, from: conversionRatesMock!)
        let viewModel = ContentViewModel()
        let calculate = viewModel.calculate(amount: 100, selectedCurrency: "USD", conversionRates: conversion, currencyToConvert: "EUR")
        XCTAssertEqual(calculate, 90.45.formatted(.currency(code: "EUR")))
    }
    
    func testCalculateCurrencyDividedByZero() {
        let conversion = try! self.decoder.decode(ConversionRates.self, from: conversionRatesMock!)
        let viewModel = ContentViewModel()
        let calculate = viewModel.calculate(amount: 100, selectedCurrency: "Unknowed", conversionRates: conversion, currencyToConvert: "EUR")
        XCTAssertEqual(calculate, "-")
    }
}
