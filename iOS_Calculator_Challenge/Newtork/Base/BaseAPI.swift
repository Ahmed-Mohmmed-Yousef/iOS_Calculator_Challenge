//
//  BaseAPI.swift
//  iOS_Calculator_Challenge
//
//  Created by Ahmed on 19/08/2022.
//

import Foundation

class BaseAPI<T: TargetType> {
    func fetchData<M: Decodable>(target: T, responseClass: M.Type, completion: @escaping(Result<M, NetworkError>) -> Void) {
        let urlString = target.baseURL + target.path
        let method    = target.method
        let headers   = target.headers ?? [:]
        let params    = buildParameters(task: target.task)
        
        guard let url = URL(string: urlString) else {
            completion(.failure(.badURL))
            return
        }
        var urlRequest = URLRequest(url: url)
        switch method {
        case .post:
            guard let httpBody = try? JSONSerialization.data(withJSONObject: params, options: []) else {
                completion(.failure(.bodyFormatError))
                return
            }
            urlRequest.httpMethod = method.rawValue
            urlRequest.httpBody   = httpBody
            
        default:
            break
        }
        print(urlString)
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = headers
        let session = URLSession(configuration: configuration)
        session.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                completion(.failure(.requestFailure(error: error)))
                return
            }
            guard let data = data else {
                completion(.failure(.nodDataRecived))
                return
            }

            do {
                print(data)
                let result = try JSONDecoder().decode(M.self, from: data)
                completion(.success(result))
            } catch let error{
                print(error.localizedDescription)
                completion(.failure(.jSONDecodingFailure))
            }

        }.resume()
//        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
//            if let error = error {
//                completion(.failure(.requestFailure(error: error)))
//                return
//            }
//            guard let data = data else {
//                completion(.failure(.nodDataRecived))
//                return
//            }
//
//            do {
//                print(data)
//                let result = try JSONDecoder().decode(M.self, from: data)
//                completion(.success(result))
//            } catch let error{
//                print(error.localizedDescription)
//                completion(.failure(.jSONDecodingFailure))
//            }
//        }.resume()
        
    }
    
    private func buildParameters(task: Task) -> [String: Any] {
        switch task {
        case .requestPlain:
            return [:]
        case .requestParametr(parameter: let parameter):
            return parameter
        }
    }
    
}

