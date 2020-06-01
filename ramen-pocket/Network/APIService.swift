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
    
    
    public func get<T: Decodable>(endpoint: Endpoint, params: [String: String]? = nil,  headers: [String: String]? = nil) -> AnyPublisher<T, Error> {
        let queryURL = baseURL.appendingPathComponent(endpoint.path())
        var components = URLComponents(url: queryURL, resolvingAgainstBaseURL: true)!
        if let params = params {
            for (_, value) in params.enumerated() {
                components.queryItems?.append(URLQueryItem(name: value.key, value: value.value))
            }
        }
        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        
        if (headers != nil) {
            for (key, value) in headers! {
                request.addValue(value, forHTTPHeaderField: key)
            }
        }
        
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
    
    public func post<T: Decodable>(endpoint: Endpoint, jsonObject: [String: String]? = nil, headers: [String: String]? = nil) -> AnyPublisher<T, Error> {
        let queryURL = baseURL.appendingPathComponent(endpoint.path())
        let components = URLComponents(url: queryURL, resolvingAgainstBaseURL: true)!
        var request = URLRequest(url: components.url!)
        if (jsonObject != nil) {
            do{
                request.httpBody = try JSONSerialization.data(withJSONObject: jsonObject!, options: JSONSerialization.WritingOptions())
            } catch let error{
                print(error)
            }
        }
        
        request.httpMethod = "POST"
        request.addValue("application/json",forHTTPHeaderField: "Content-Type")
        request.addValue("application/json",forHTTPHeaderField: "Accept")
        
        if (headers != nil) {
            for (key, value) in headers! {
                request.addValue(value, forHTTPHeaderField: key)
            }
        }
        
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
