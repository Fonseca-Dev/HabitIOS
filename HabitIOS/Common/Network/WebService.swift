//
//  WebService.swift
//  HabitIOS
//
//  Created by Kaue Rocha da Fonseca on 25/05/26.
//

import Foundation
import Combine

enum WebService {
    
    enum Endpoint: String {
        case base = "https://habitplus-api.tiagoaguiar.dev"
        case postUser = "/users"
        case loginUser = "/auth/login"
        case refreshToken = "/auth/refresh-token"
        case habits = "/users/me/habits"
    }
    
    enum Method: String {
        case get
        case put
        case post
        case delete
    }
    
    enum NetworkError {
        case badRequest
        case notFound
        case unauthorized
        case internalServerError
    }
    
    enum Result{
        case success(Data)
        case failure(NetworkError, Data?)
    }
    
    enum ContentType: String {
        case json = "application/json"
        case formUrl = "application/x-www-form-urlencoded"
    }
    
    private static func completeUrl(path: Endpoint) -> URLRequest? {
        guard let url = URL(string: "\(Endpoint.base.rawValue)\(path.rawValue)") else {return nil}
        
        return URLRequest(url: url)
    }
    
    // Call para o json
    // <T: Encodable> -> Esse metodo podera receber qualquer coisa que tiver o protocol Encodable
    public static func call<T: Encodable>(path: Endpoint, method: Method = .get, body: T, completion: @escaping (Result) -> Void){
        guard let jsonData = try? JSONEncoder().encode(body) else {return}
        call(path: path, method: method, contentType: .json, data: jsonData, completion: completion)
    }
    
    // Call para buscar habits sem json
    public static func call(path: Endpoint, method: Method = .get, completion: @escaping (Result) -> Void){
        call(path: path, method: method, contentType: .json, data: nil, completion: completion)
    }
    
    // Call para o UrlFormCode
    public static func call(path: Endpoint, method: Method = .post, params: [URLQueryItem], completion: @escaping (Result) -> Void){
        guard var urlRequest = completeUrl(path: path) else {return}
        guard let absoluteUrl = urlRequest.url?.absoluteString else {return}
        var components = URLComponents(string: absoluteUrl)
        components?.queryItems = params
        call(path: path, method: method, contentType: .formUrl, data: components?.query?.data(using: .utf8), completion: completion)
    }
    
    private static func call(path: Endpoint, method: Method, contentType: ContentType, data: Data?, completion: @escaping (Result) -> Void){
        guard var urlRequest = completeUrl(path: path) else {return}
        
        _ = LocalDataSource.shared.getUserAuth()
            .sink { userAuth in
                if let userAuth = userAuth {
                    urlRequest.setValue("\(userAuth.tokenType) \(userAuth.idToken)", forHTTPHeaderField: "Authorization")
                }
                urlRequest.httpMethod = method.rawValue
                urlRequest.setValue("application/json", forHTTPHeaderField: "accept")
                urlRequest.setValue(contentType.rawValue, forHTTPHeaderField: "Content-Type")
                urlRequest.httpBody = data
                
                let task = URLSession.shared.dataTask(with: urlRequest){data,response,error in
                    // Roda em backgorund (Non-MainThread)
                    guard let data = data, error == nil else {
                        print(error)
                        completion(.failure(.internalServerError, nil))
                        return
                    }
                    
                    if let r = response as? HTTPURLResponse {
                        switch r.statusCode {
                        case 500:
                            completion(.failure(.internalServerError, data))
                        case 401:
                            completion(.failure(.unauthorized, data))
                            break
                        case 400:
                            completion(.failure(.badRequest, data))
                            break
                        case 200:
                            completion(.success(data))
                        default:
                            break
                        }
                    }
                    
                    print(String(data: data, encoding: .utf8)!)
                    
                    print("response\n \(response)")
                    
                }
                task.resume()
            }
    }
}
