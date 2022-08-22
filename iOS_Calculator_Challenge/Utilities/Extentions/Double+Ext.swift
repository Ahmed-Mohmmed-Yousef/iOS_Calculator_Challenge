//
//  Double+Ext.swift
//  iOS_Calculator_Challenge
//
//  Created by Ahmed on 22/08/2022.
//

import Foundation

extension Double {
    var stringPrice: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "USD"
        return formatter.string(from: NSNumber(value: self)) ?? "n/a"
    }
    
}
