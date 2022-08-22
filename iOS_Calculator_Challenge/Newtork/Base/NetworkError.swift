//
//  NetworkError.swift
//  iOS_Calculator_Challenge
//
//  Created by Ahmed on 19/08/2022.
//

import Foundation

enum NetworkError: Error {
    case badURL
    case bodyFormatError
    case requestFailure(error: Error)
    case nodDataRecived
    case jSONDecodingFailure
    
    var description: String {
        switch self {
        case .badURL:
            return "Bad url format"
        case .bodyFormatError:
            return "Body data is wrong"
        case .requestFailure(let error):
            return error.localizedDescription
        case .nodDataRecived:
            return "No data recived"
        case .jSONDecodingFailure:
            return "JSON decoding error"
        }
    }
}
