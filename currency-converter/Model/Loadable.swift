//
//  Loadable.swift
//  currency-converter
//
//  Created by Dorian Duplaix on 23/11/2023.
//

import Foundation
import Combine

enum CustomError: Error {
    case cancelled
}

enum Loadable<Value> {
    case notRequested
    case isLoading(last: Value?, cancelBag: Cancellable)
    case loaded(Value)
    case failed(Error)
    
    var value: Value? {
        switch self {
            case let .loaded(value):
                return value
            case let .isLoading(last, _):
                return last
            default: return nil
        }
    }
    
    var loading: Bool {
        switch self {
            case .isLoading:
                return true
            default:
                return false
        }
    }
    
    var error: Error? {
        switch self {
            case let .failed(error):
                return error
            default:
                return nil
        }
    }
}

extension Loadable {
    @MainActor 
    mutating func setIsLoading(_ cancelToken: Cancellable) {
        self = .isLoading(last: value, cancelBag: cancelToken)
    }
    
    @MainActor 
    mutating func setError(_ error: Error) {
        self = .failed(error)
    }
    
    @MainActor 
    mutating func setValue(_ value: Value) {
        self = .loaded(value)
    }
    
    mutating func cancelLoading() {
        switch self {
            case let .isLoading(last, cancelToken):
                cancelToken.cancel()
                if let last {
                    self = .loaded(last)
                } else {
                    self = .failed(CustomError.cancelled)
                }
            default:
                break
        }
    }
}
