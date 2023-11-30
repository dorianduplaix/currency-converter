//
//  DefaultStorage.swift
//  currency-converter
//
//  Created by Dorian Duplaix on 30/11/2023.
//

import Foundation
import RealmSwift

fileprivate let realm = try! Realm()

struct DefaultStorage: Storage {
    func save<Value: Model>(value: Value)  {
        realm.writeAsync {
            realm.add(value.toDataBaseObject())
        }
    }
    
    func load<Value: Object>() -> Value? {
        return realm.objects(Value.self).first
    }
}
