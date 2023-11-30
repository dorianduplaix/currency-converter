//
//  Model.swift
//  currency-converter
//
//  Created by Dorian Duplaix on 30/11/2023.
//

import Foundation
import RealmSwift

protocol Model {
    func toDataBaseObject() -> Object
}
