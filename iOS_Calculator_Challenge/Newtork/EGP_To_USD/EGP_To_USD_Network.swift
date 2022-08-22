//
//  EGP_To_USD_Network.swift
//  iOS_Calculator_Challenge
//
//  Created by Ahmed on 22/08/2022.
//

import Foundation

enum EGP_To_USD_Network {
    case getResult(egp: Double)
}

extension EGP_To_USD_Network: TargetType {
    var baseURL: String {
        ApiPath.baseURL
    }
    
    var path: String {
        switch self {
        case .getResult(egp: let egp):
            return ApiPath.apiKey + ApiPath.egpToUsdPath + "\(egp)"
        }
    }
    
    var method: HTTPMethod {
        .get
    }
    
    var task: Task {
        .requestPlain
    }
    
    var headers: [String : String]? {
        ["Content-Type": "application/json"]
    }
    
    
}
