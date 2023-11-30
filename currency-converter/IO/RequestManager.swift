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
}
