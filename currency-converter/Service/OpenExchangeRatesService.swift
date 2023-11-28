//
//  OpenExchangeRatesService.swift
//  currency-converter
//
//  Created by Dorian Duplaix on 23/11/2023.
//

import Foundation
import Combine

class ExchangeRatesService: ObservableObject {
    @Published private (set) var conversionData: Loadable<ConversionRates> = .notRequested
    @Published private (set) var currenciesData: Loadable<Currencies> = .notRequested
    private let request: Request
    
    required init(request: Request) {
        self.request = request
    }
    
    func getConversions() async {
        return await withCheckedContinuation { continuation in
            DispatchQueue.main.async {
                self.conversionData.setIsLoading(self.request
                    .getData(endpoint: OpenExchangeRatesUrl.latest(base: "USD").toUrl(), type: ConversionRates.self)
                    .sink(receiveCompletion: { completion in
                            switch completion {
                                case .finished:
                                    break
                                case let .failure(error):
                                    DispatchQueue.main.async {
                                        self.conversionData.setError(error)
                                        continuation.resume()
                                    }
                            }
                        },
                        receiveValue: { (value: ConversionRates) in
                            DispatchQueue.main.async {
                                self.conversionData.setValue(value)
                                continuation.resume()
                            }
                        }
                    )
                )
            }
        }
    }
    
    func getCurrencies() async {
        return await withCheckedContinuation { continuation in
            DispatchQueue.main.async {
                self.currenciesData.setIsLoading(self.request
                    .getData(endpoint: OpenExchangeRatesUrl.currencies.toUrl(), type: Currencies.self)
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
                          receiveValue: { (value: Currencies) in
                    DispatchQueue.main.async {
                        self.currenciesData.setValue(value)
                        continuation.resume()
                    }
                }
                         )
                )
            }
        }
    }
}
