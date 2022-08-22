//
//  EGP_To_USD_Response.swift
//  iOS_Calculator_Challenge
//
//  Created by Ahmed on 19/08/2022.
//

import Foundation

// MARK: - ConvertionResponse
struct EGP_To_USD_Response: Codable {
    let result: String
    let conversionRate, conversionResult: Double

    enum CodingKeys: String, CodingKey {
        case result
        case conversionRate = "conversion_rate"
        case conversionResult = "conversion_result"
    }
}

