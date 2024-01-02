//
//  ConversionServiceTests.swift
//  currency-converterTests
//
//  Created by Dorian Duplaix on 01/01/2024.
//

import Foundation
import XCTest
import SwiftUI
@testable import currency_converter

final class ConversionServiceTests: XCTestCase {
    private var decoder = JSONDecoder()

    func testLoadFromStorage() {
        let storageMock = StorageMock()
        let requestMock = RequestMock(.latest(base: "USD"))
        let service = currency_converter.ConversionService(storageMock, request: requestMock)
        XCTAssertTrue(storageMock.loadHasBeenCalled)
    }
    
    func testNotRequestedValueByDefault() {
        let storageMock = StorageMock()
        let requestMock = RequestMock(.latest(base: "USD"))
        let service = currency_converter.ConversionService(storageMock, request: requestMock)
        
        switch service.conversionData {
            case .notRequested:
                XCTAssertTrue(true)
            default:
                XCTAssert(false, "values should be .notRequested, something went wrong")
        }
    }
    
    func testShouldTriggerNewValueFetch() {
        let storageMock = StorageMock()
        let requestMock = RequestMock(.latest(base: "USD"))
        let service = currency_converter.ConversionService(storageMock, request: requestMock)
        let expectation = self.expectation(description: #function)
        
        requestMock.dataToReturn = conversionRatesMock!
        let conversionRatesMock = try! JSONDecoder().decode(ConversionRates.self, from: conversionRatesMock!)
        
        // create comparaison data before sink to avoid unneeded waiting time
        let cancellable = service.$conversionData.sink { loadable in
            switch loadable {
                case .loaded(let values):
                    // Since it is a mock we don't want to compare the date
                    XCTAssertEqual(values.base, conversionRatesMock.base)
                    XCTAssertEqual(values.rates, conversionRatesMock.rates)
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
        let service = currency_converter.ConversionService(storageMock, request: requestMock)
        let expectation = self.expectation(description: #function)
        requestMock.isError = true
        
        requestMock.dataToReturn = conversionRatesMock!
        let conversionRatesMock = try! JSONDecoder().decode(ConversionRates.self, from: conversionRatesMock!)
        
        // create comparaison data before sink to avoid unneeded waiting time
        let cancellable = service.$conversionData.sink { loadable in
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
