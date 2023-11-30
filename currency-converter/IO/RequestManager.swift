//
//  RequestManager.swift
//  currency-converter
//
//  Created by Dorian Duplaix on 07/11/2023.
//

import Foundation
import Combine

class RequestManager: Request {
    private let endpoint: OpenExchangeRatesUrl
    
    required init(_ url: OpenExchangeRatesUrl) {
        self.endpoint = url
    }
    
    func getData<T: Codable>() -> AnyPublisher<T, Error> {
        return URLSession.shared.dataTaskPublisher(for: endpoint.toUrl())
            .tryMap { (data, response) -> Data in
                guard let httpResponse = response as? HTTPURLResponse, 200...299 ~= httpResponse.statusCode else {
                    throw NetworkError.responseError
                }
                return data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
    //    func getData<T: Codable>() -> AnyPublisher<T, Error> {
    ////        return Future<T, Error> { [weak self] promise in
    ////            guard let self = self else {
    ////                return promise(.failure(NetworkError.invalidURL))
    ////            }
    //            URLSession.shared.dataTaskPublisher(for: endpoint)
    //                .tryMap { (data, response) -> Data in
    //                    guard let httpResponse = response as? HTTPURLResponse, 200...299 ~= httpResponse.statusCode else {
    //                        throw NetworkError.responseError
    //                    }
    //                    return data
    //                }
    //                .decode(type: T.self, decoder: JSONDecoder())
    //                .receive(on: RunLoop.main)
    //                .eraseToAnyPublisher()
    ////                .sink(receiveCompletion: { completion in
    ////                    if case let .failure(error) = completion {
    ////                        switch error {
    ////                            case let decodingError as DecodingError:
    ////                                promise(.failure(decodingError))
    ////                            case let apiError as NetworkError:
    ////                                promise(.failure(apiError))
    ////                            default:
    ////                                promise(.failure(NetworkError.unknown))
    ////                        }
    ////                    }
    ////                }, receiveValue: { data in
    ////                    print(data)
    ////                    promise(.success(data))
    ////                })
    ////                .store(in: &self.cancellables)
    //        }
}

