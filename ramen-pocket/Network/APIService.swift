//
//  APIService.swift
//  ramen-pocket
//
//  Created by 姚韋辰 on 2020/5/27.
//  Copyright © 2020 姚韋辰. All rights reserved.
//

import Foundation
import Combine

public struct APIService {
    
    let baseURL = URL(string: "https://api.virtualquantum.tw")!
    public static let shared = APIService()
    let decoder = JSONDecoder()
    
    public enum APIError: Error {
        case noResponse
        case jsonDecodingError(error: Error)
        case jsonEcodingError(error: Error)
        case networkError(error: Error)
    }
    
    
    public func get<T: Codable>(endpoint: Endpoint, params: [String: String]? = nil) -> AnyPublisher<T, Error> {
        let queryURL = baseURL.appendingPathComponent(endpoint.path())
        var components = URLComponents(url: queryURL, resolvingAgainstBaseURL: true)!
        if let params = params {
            for (_, value) in params.enumerated() {
                components.queryItems?.append(URLQueryItem(name: value.key, value: value.value))
            }
        }
        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { output in
                guard let _ = output.response as? HTTPURLResponse else {
                    throw APIError.noResponse
                }
                return output.data
        }
        .decode(type: T.self, decoder: JSONDecoder())
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
    
    public func post<T: Codable>(endpoint: Endpoint, jsonObject: [String: String]) -> AnyPublisher<T, Error> {
        let queryURL = baseURL.appendingPathComponent(endpoint.path())
        let components = URLComponents(url: queryURL, resolvingAgainstBaseURL: true)!
        var request = URLRequest(url: components.url!)
        do{
            request.httpBody = try JSONSerialization.data(withJSONObject: jsonObject, options: JSONSerialization.WritingOptions())
        } catch let error{
            print(error)
        }
        request.httpMethod = "POST"
        request.addValue("application/json",forHTTPHeaderField: "Content-Type")
        request.addValue("application/json",forHTTPHeaderField: "Accept")
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { output in
                guard let _ = output.response as? HTTPURLResponse else {
                    throw APIError.noResponse
                }
                return output.data
        }
        .decode(type: T.self, decoder: JSONDecoder())
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
    
    
}
