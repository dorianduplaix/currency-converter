//
//  NumberFormatter+extension.swift
//  currency-converter
//
//  Created by Dorian Duplaix on 10/11/2023.
//

import Foundation

extension NumberFormatter {
    static var twoDecimals: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        formatter.maximumIntegerDigits = 8
        return formatter
    }
}
