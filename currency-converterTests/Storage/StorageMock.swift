//
//  StorageMock.swift
//  currency-converterTests
//
//  Created by Dorian Duplaix on 02/01/2024.
//

import Foundation
import RealmSwift
@testable import currency_converter

class StorageMock: Storage {
    private (set) var valueToBeSaved: Object? = nil
    var objectToBeLoaded: Object? = nil
    var loadHasBeenCalled = false
    var saveHasBeenCalled = false
    
    func load<Value: Object>() -> Value? {
        loadHasBeenCalled = true
        return objectToBeLoaded as? Value
    }
    
    func save<Value: Model>(value: Value) {
        saveHasBeenCalled = true
        valueToBeSaved = value.toDataBaseObject()
    }
}
