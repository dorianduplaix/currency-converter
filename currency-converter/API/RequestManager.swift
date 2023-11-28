//
//  RequestManager.swift
//  currency-converter
//
//  Created by Dorian Duplaix on 07/11/2023.
//

import Foundation
import Combine

extension NetworkError: LocalizedError {
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

class RequestManager: Request {
    static let shared = RequestManager()
    private var cancellables = Set<AnyCancellable>()
    
    func getData<T: Decodable>(endpoint: URL, type: T.Type) -> Future<T, Error> {
        return Future<T, Error> { [weak self] promise in
            guard let self = self else {
                return promise(.failure(NetworkError.invalidURL))
            }
            URLSession.shared.dataTaskPublisher(for: endpoint)
                .tryMap { (data, response) -> Data in
                    guard let httpResponse = response as? HTTPURLResponse, 200...299 ~= httpResponse.statusCode else {
                        throw NetworkError.responseError
                    }
                    return data
                }
                .decode(type: T.self, decoder: JSONDecoder())
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { completion in
                    if case let .failure(error) = completion {
                        switch error {
                            case let decodingError as DecodingError:
                                promise(.failure(decodingError))
                            case let apiError as NetworkError:
                                promise(.failure(apiError))
                            default:
                                promise(.failure(NetworkError.unknown))
                        }
                    }
                }, receiveValue: { data in
                    print(data)
                    promise(.success(data))
                })
                .store(in: &self.cancellables)
        }
    }
}
