//
//  OpenExchangeRatesUrl.swift
//  currency-converter
//
//  Created by Dorian Duplaix on 06/11/2023.
//

import Foundation
import Combine

enum OpenExchangeRatesUrl {
    private static let baseUrl = "https://openexchangerates.org/api/"
    private static let appId = "b905c50482a041f3907f7e2c62cff3be" // put yours here
    case conversion(value: Double, from: String, to: String)
    case currencies
    case historical(appId: String, base: String, date: Date)
    case latest(base: String)
    case ohlc(base: String, startTime: Date, period: String, symbols: [String])
    case usage
    
    func toUrl() -> URL {
        switch self {
            case .conversion(let value, let from, let to):
                return url(path: "convert/\(value)/\(from)/\(to)", queryItems: ["app_id": OpenExchangeRatesUrl.appId])
            case .currencies:
                return url(path: "currencies.json", queryItems: ["app_id": OpenExchangeRatesUrl.appId])
            case .historical(let appId, let base, let date):
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd"
                return url(path: "historical/\(formatter.string(from: date)).json", 
                           queryItems: ["app_id": appId, "base": base])
            case .latest(let base):
                return url(path: "latest.json", queryItems: ["app_id": OpenExchangeRatesUrl.appId, "base": base])
            case .ohlc(let base, let startTime, let period, let symbols):
                let formatter = ISO8601DateFormatter()
                return url(path: "ohlc.json", queryItems: ["app_id": OpenExchangeRatesUrl.appId, 
                                                           "base": base,
                                                           period: "period",
                                                           "start_time": formatter.string(from: startTime),
                                                           "symbols": symbols.joined(separator: ",")])
            case .usage:
                return url(path: "usage.json", queryItems: ["app_id": OpenExchangeRatesUrl.appId])
        }
    }
    
    private func url(path: String, queryItems: [String: String]) -> URL {
        var components = URLComponents(string: OpenExchangeRatesUrl.baseUrl)
        components?.path += path
        components?.queryItems = queryItems.map { key, value in
            URLQueryItem(name: key, value: value)
        }
        return components!.url!
    }
}
