//
//  CurrencyService.swift
//  currency-converter
//
//  Created by Dorian Duplaix on 30/11/2023.
//

import Foundation
import Combine

class CurrencyService: Service, ObservableObject {
    @Published private (set) var currenciesData: Loadable<Currency> = .notRequested
    private let storage: Storage
    private let request: Request
    
    required init(_ storage: Storage, request: Request) {
        self.storage = storage
        self.request = request
    }
    
    private func getCurrencies() async {
        return await withCheckedContinuation { continuation in
            DispatchQueue.main.async {
                self.currenciesData.setIsLoading(self.request
                    .getData()
                    .sink(receiveCompletion: { completion in
                        switch completion {
                            case .finished:
                                break
                            case let .failure(error):
                                DispatchQueue.main.async {
                                    self.currenciesData.setError(error)
                                    continuation.resume()
                                }
                        }
                    },
                          receiveValue: { (value: [String: String]) in
                    DispatchQueue.main.async {
                        self.currenciesData.setValue(value)
                        print("Success call, CURRENCY VALUE is : ", value)
                        continuation.resume()
                    }
                }
                         )
                )
            }
        }
    }
    
    func loadIfNeeded() async {
        switch currenciesData {
            case .notRequested:
                return await self.getCurrencies()
            default:
                return
        }
    }
}
