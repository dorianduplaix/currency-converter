//
//  Storage.swift
//  currency-converter
//
//  Created by Dorian Duplaix on 30/11/2023.
//

import Foundation
import RealmSwift

protocol Storage {
    func load<Value: Object> () -> Value?
    func save<Value: Model>(value: Value)
}
