////
////  OpenExchangeRatesService.swift
////  currency-converter
////
////  Created by Dorian Duplaix on 23/11/2023.
////
//
//import Foundation
//import Combine
//
//class ExchangeRatesService: Service, ObservableObject {
//    @Published private (set) var conversionData: Loadable<ConversionRates> = .notRequested {
//        didSet {
//            switch conversionData {
//                case .loaded(let rates):
//                    self.storage.save(value: rates)
//                default: return
//            }
//        }
//    }
//    @Published private (set) var currenciesData: Loadable<[String: String]> = .notRequested {
//        didSet {
//            switch currenciesData {
//                case .loaded(let currencies):
//                    self.storage.save(value: currencies)
//                default: return
//            }
//        }
//    }
//    private let storage: Storage
//    private let request: Request
//    
//    required init(_ storage: Storage, request: Request) {
//        self.storage = storage
//        self.request = request
//        guard let initialValues: ConversionRatesDB = storage.load() else {
//            return
//        }
//        self.conversionData = .loaded(ConversionRates(initialValues))
//    }
//    
//    private func getConversions() async {
////        print("HEY CONVERSIONS")
////        let conversionData = ConversionRates(disclaimer: "", license: "", timestamp: Date(), base: "100", rates: ["USD": 150])
////        await self.conversionData.setValue(conversionData)
////        return
//        return await withCheckedContinuation { continuation in
//            DispatchQueue.main.async {
//                self.conversionData.setIsLoading(self.request
//                    .getData()
//                    .sink(receiveCompletion: { completion in
//                            switch completion {
//                                case .finished:
//                                    break
//                                case let .failure(error):
//                                    DispatchQueue.main.async {
//                                        self.conversionData.setError(error)
//                                        continuation.resume()
//                                    }
//                            }
//                        },
//                        receiveValue: { (value: ConversionRates) in
//                            DispatchQueue.main.async {
//                                self.conversionData.setValue(value)
//                                continuation.resume()
//                            }
//                        }
//                    )
//                )
//            }
//        }
//    }
//    
//    private func getCurrencies() async {
////        print("HEY CURRENCIES")
////        let currenciesData = ["USD": "Dollar"]
////        await self.currenciesData.setValue(currenciesData)
////        return
//        return await withCheckedContinuation { continuation in
//            DispatchQueue.main.async {
//                self.currenciesData.setIsLoading(self.request
//                    .getData()
//                    .sink(receiveCompletion: { completion in
//                        switch completion {
//                            case .finished:
//                                break
//                            case let .failure(error):
//                                DispatchQueue.main.async {
//                                    self.currenciesData.setError(error)
//                                    continuation.resume()
//                                }
//                        }
//                    },
//                          receiveValue: { (value: [String: String]) in
//                    DispatchQueue.main.async {
//                        self.currenciesData.setValue(value)
//                        continuation.resume()
//                    }
//                }
//                         )
//                )
//            }
//        }
//    }
//    
//    func loadIfNeeded() async {
//        switch conversionData {
//            case .loaded(let loadedValue):
//                if loadedValue.timestamp.minuteSince > MIN_BEFORE_REFRESH {
//                    return await self.load()
//                }
//            case .notRequested:
//                return await self.load()
//            default:
//                return
//        }
//    }
//}
