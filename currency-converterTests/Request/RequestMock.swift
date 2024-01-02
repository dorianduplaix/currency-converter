//
//  RequestMock.swift
//  currency-converterTests
//
//  Created by Dorian Duplaix on 01/01/2024.
//

import Foundation
import Combine
@testable import currency_converter

class RequestMock: Request {
    var isError = false
    var getDataHasBeenCalled = false
    var dataToReturn: Data!
    private var url: currency_converter.OpenExchangeRatesUrl
    
    required init(_ url: currency_converter.OpenExchangeRatesUrl) {
        self.url = url
    }
    
    func getData<T>() -> AnyPublisher<T, Error> where T : Decodable, T : Encodable {
        getDataHasBeenCalled = true
        guard isError else {
            let decodedValue: T = try! JSONDecoder().decode(T.self, from: dataToReturn)
            return Result<T, Error>.success(decodedValue).publisher.eraseToAnyPublisher()
        }
        return Result<T, Error>.failure(NetworkError.unknown).publisher.eraseToAnyPublisher()
    }
}
