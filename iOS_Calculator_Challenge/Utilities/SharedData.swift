//
//  Notifications.swift
//  iOS_Calculator_Challenge
//
//  Created by Ahmed on 19/08/2022.
//

import Foundation

extension Notification.Name {
    
    static let currencyConversion = Notification.Name("currencyConversion")
    
    static let calculationResult = Notification.Name("calculationResult")
    
}

class FireNotification {
    static func post(name: Notification.Name, info: [String : Any]? = nil) {
        NotificationCenter.default.post(name: name, object: nil, userInfo: info)
    }
}

class SharedData {
    static let shared = SharedData()
    
    private init() {
        setLastCalculationResult(value: nil)
        setLastCurrencyResult(value: nil)
    }
    
    private let defaults = UserDefaults.standard
    private let kCURRENCY = "currencyConversion"
    private let kCALCULATE = "calculationResult"
    
    var lastCurrencyResult: Double? {
        defaults.value(forKey: kCURRENCY) as? Double
    }
    
    var lastCalculationResult: Double? {
        defaults.value(forKey: kCALCULATE) as? Double
    }
    
    func setLastCurrencyResult(value: Double?) {
        defaults.set(value, forKey: kCURRENCY)
    }
    
    func setLastCalculationResult(value: Double?) {
        defaults.set(value, forKey: kCALCULATE)
    }
}
