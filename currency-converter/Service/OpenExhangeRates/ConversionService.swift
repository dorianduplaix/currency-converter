//
//  ConversionService.swift
//  currency-converter
//
//  Created by Dorian Duplaix on 30/11/2023.
//

import Foundation
import Combine

class ConversionService: Service, ObservableObject {
    @Published private (set) var conversionData: Loadable<ConversionRates> = .notRequested {
        didSet {
            switch conversionData {
                case .loaded(let rates):
                    self.storage.save(value: rates)
                default: return
            }
        }
    }
    private let storage: Storage
    private let request: Request
    
    required init(_ storage: Storage, request: Request) {
        self.storage = storage
        self.request = request
        guard let initialValues: ConversionRatesDB = storage.load() else {
            return
        }
        self.conversionData = .loaded(ConversionRates(initialValues))
    }
    
    private func getConversions() async {
        //        print("HEY CONVERSIONS")
        //        let conversionData = ConversionRates(disclaimer: "", license: "", timestamp: Date(), base: "100", rates: ["USD": 150])
        //        await self.conversionData.setValue(conversionData)
        //        return
        return await withCheckedContinuation { continuation in
            DispatchQueue.main.async {
                self.conversionData.setIsLoading(self.request
                    .getData()
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
    
    func loadIfNeeded() async {
        switch conversionData {
            case .loaded(let loadedValue):
                let timeSinceLastCall = (loadedValue.timestamp.timeIntervalSince1970 - Date().timeIntervalSince1970) / 60
                if timeSinceLastCall > REFRESH_TIME {
                    return await self.getConversions()
                }
            case .notRequested:
                return await self.getConversions()
            default:
                return
        }
    }
}
