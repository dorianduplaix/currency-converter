//
//  Request.swift
//  currency-converter
//
//  Created by Dorian Duplaix on 08/11/2023.
//

import Foundation
import Combine

protocol Request {
    init(_ url: OpenExchangeRatesUrl)
    func getData<T: Codable>() -> AnyPublisher<T, Error>
}
