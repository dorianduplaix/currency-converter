//
//  Request.swift
//  currency-converter
//
//  Created by Dorian Duplaix on 08/11/2023.
//

import Foundation
import Combine

enum NetworkError: Error {
    case invalidURL
    case responseError
    case unknown
}

protocol Request {
    func getData<T: Decodable>(endpoint: URL, type: T.Type) -> Future<T, Error>
}
