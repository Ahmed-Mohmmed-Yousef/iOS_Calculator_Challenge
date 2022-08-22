//
//  TargetType.swift
//  iOS_Calculator_Challenge
//
//  Created by Ahmed on 19/08/2022.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

enum Task {
    case requestPlain
    case requestParametr(parameter: [String: Any])
}

protocol TargetType {
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var task: Task { get }
    var headers: [String : String]? { get }
}
