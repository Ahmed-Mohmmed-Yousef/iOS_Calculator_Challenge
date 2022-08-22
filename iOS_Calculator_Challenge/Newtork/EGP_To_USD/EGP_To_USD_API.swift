//
//  EGP_To_USD_API.swift
//  iOS_Calculator_Challenge
//
//  Created by Ahmed on 22/08/2022.
//

import Foundation

protocol EGP_To_USD_APIProtocol {
    func getResult(egp: Double, completion: @escaping(Result<EGP_To_USD_Response, NetworkError>) -> Void)
}

class EGP_To_USD_API: BaseAPI<EGP_To_USD_Network>, EGP_To_USD_APIProtocol {
    
    static let shared: EGP_To_USD_APIProtocol = EGP_To_USD_API()
    
    func getResult(egp: Double, completion: @escaping (Result<EGP_To_USD_Response, NetworkError>) -> Void) {
        self.fetchData(target: .getResult(egp: egp), responseClass: EGP_To_USD_Response.self) { response in
            switch response {
            case .success(let result):
                completion(.success(result))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
