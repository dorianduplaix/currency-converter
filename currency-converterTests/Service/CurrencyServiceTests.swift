//
//  CurrencyServiceTests.swift
//  currency-converterTests
//
//  Created by Dorian Duplaix on 02/01/2024.
//

import Foundation
import XCTest
import SwiftUI
@testable import currency_converter

final class CurrencyServiceTests: XCTestCase {
    private var decoder = JSONDecoder()
    
    func testNoStorageForCurrency() {
        let storageMock = StorageMock()
        let requestMock = RequestMock(.latest(base: "USD"))
        let service = currency_converter.CurrencyService(storageMock, request: requestMock)
        XCTAssertFalse(storageMock.loadHasBeenCalled)
    }
    
    func testNotRequestedValueByDefault() {
        let storageMock = StorageMock()
        let requestMock = RequestMock(.latest(base: "USD"))
        let service = currency_converter.CurrencyService(storageMock, request: requestMock)
        
        switch service.currenciesData {
            case .notRequested:
                XCTAssertTrue(true)
            default:
                XCTAssert(false, "values should be .notRequested, something went wrong")
        }
    }
    
    func testShouldTriggerNewValueFetch() {
        let storageMock = StorageMock()
        let requestMock = RequestMock(.latest(base: "USD"))
        let service = currency_converter.CurrencyService(storageMock, request: requestMock)
        let expectation = self.expectation(description: #function)
        
        requestMock.dataToReturn = currenciesMock!
        let conversionRatesMock = try! JSONDecoder().decode(Currency.self, from: currenciesMock!)
        
        // create comparaison data before sink to avoid unneeded waiting time
        let cancellable = service.$currenciesData.sink { loadable in
            switch loadable {
                case .loaded(let values):
                    XCTAssertEqual(values, conversionRatesMock)
                    expectation.fulfill()
                default:
                    break
            }
        }
        Task {
            await service.loadIfNeeded()
        }
        waitForExpectations(timeout: 0.5)
        cancellable.cancel()
    }
    
    func testShouldTriggerNewValueFetchAndFail() {
        let storageMock = StorageMock()
        let requestMock = RequestMock(.latest(base: "USD"))
        let service = currency_converter.CurrencyService(storageMock, request: requestMock)
        let expectation = self.expectation(description: #function)
        requestMock.isError = true
        
        requestMock.dataToReturn = currenciesMock!
        let conversionRatesMock = try! JSONDecoder().decode(Currency.self, from: currenciesMock!)
        
        // create comparaison data before sink to avoid unneeded waiting time
        let cancellable = service.$currenciesData.sink { loadable in
            switch loadable {
                case .failed(_):
                    XCTAssertTrue(true)
                    expectation.fulfill()
                default:
                    break
            }
        }
        Task {
            await service.loadIfNeeded()
        }
        waitForExpectations(timeout: 0.5)
        cancellable.cancel()
    }
}
