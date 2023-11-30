//
//  Service.swift
//  currency-converter
//
//  Created by Dorian Duplaix on 30/11/2023.
//

import Foundation

protocol Service {
    init(_ storage: Storage, request: Request)
    func loadIfNeeded() async
}
