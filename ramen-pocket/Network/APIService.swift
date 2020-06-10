//
//  APIService.swift
//  ramen-pocket
//
//  Created by 姚韋辰 on 2020/5/27.
//  Copyright © 2020 姚韋辰. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

struct APIService {
    
    @EnvironmentObject private var appState: AppState

    public static let shared = APIService()

    let baseURL = URL(string: "https://api.virtualquantum.tw")!
    let decoder = JSONDecoder()
    
    enum APIError: Error, LocalizedError {
        case noResponse, apiError(reason: String), parserError(reason: String)
        
        var errorDescription: String? {
            switch self {
            case .noResponse:
                return "No response"
            case .apiError(let reason), .parserError(let reason):
                return reason
            }
        }
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
        
        // Set dateDecodingStrategy to iso8601 for decoding date format in JSON
        let decoder = JSONDecoder()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        
        let preferences = UserDefaults.standard
        let idToken = preferences.string(forKey: "idToken") ?? ""
        request.addValue(idToken, forHTTPHeaderField: "Authorization")
        
        Logger.shared.log("[GET] \(request.debugDescription)\n\(request.allHTTPHeaderFields)")

        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { output in
                guard let response = output.response as? HTTPURLResponse else {
                    throw APIError.noResponse
                }
                if !(200..<300 ~= response.statusCode) {
                    let errorResponse = try decoder.decode(ErrorResponse.self, from: output.data)
                    throw APIError.apiError(reason: errorResponse.reason)
                }
                if(response.statusCode == 401) {
                    self.appState.idToken = ""
                }
                return output.data
            }
            .mapError { error in
                return APIError.apiError(reason: error.localizedDescription)
            }
            .decode(type: T.self, decoder: decoder)
            .mapError { error in
                if let error = error as? DecodingError {
                    var errorToReport = error.localizedDescription
                    switch error {
                    case .dataCorrupted(let context):
                        let details = context.underlyingError?.localizedDescription ?? context.codingPath.map { $0.stringValue }.joined(separator: ".")
                        errorToReport = "\(context.debugDescription) - (\(details))"
                    case .keyNotFound(let key, let context):
                        let details = context.underlyingError?.localizedDescription ?? context.codingPath.map { $0.stringValue }.joined(separator: ".")
                        errorToReport = "\(context.debugDescription) (key: \(key), \(details))"
                    case .typeMismatch(let type, let context), .valueNotFound(let type, let context):
                        let details = context.underlyingError?.localizedDescription ?? context.codingPath.map { $0.stringValue }.joined(separator: ".")
                        errorToReport = "\(context.debugDescription) (type: \(type), \(details))"
                    default:
                        break
                    }
                    return APIError.parserError(reason: errorToReport)
                }  else {
                    return APIError.apiError(reason: error.localizedDescription)
                }
            }
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
        
        print(request)
        
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
    
    func handleReceiveCompletion(_ completion: Subscribers.Completion<Error>) {
        switch completion {
        case .finished:
            break
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
}
