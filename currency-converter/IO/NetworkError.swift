//
//  NetworkError.swift
//  currency-converter
//
//  Created by Dorian Duplaix on 30/11/2023.
//

import Foundation

enum NetworkError: Error, LocalizedError {
    case invalidURL
    case responseError
    case unknown
    
    var errorDescription: String? {
        switch self {
            case .invalidURL:
                return NSLocalizedString("Invalid URL", comment: "")
            case .responseError:
                return NSLocalizedString("Unexpected status code", comment: "")
            case .unknown:
                return NSLocalizedString("Unknown error", comment: "")
        }
    }
}
