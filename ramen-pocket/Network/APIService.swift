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
    
    //MARK: -GET-
    func get<T: Decodable>(endpoint: Endpoint, params: [String: String]? = nil,  headers: [String: String]? = nil) -> AnyPublisher<T, Error> {
        
        let queryURL = baseURL.appendingPathComponent(endpoint.path())
        var components = URLComponents(url: queryURL, resolvingAgainstBaseURL: true)!
        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        
        // Add parameters
        if let params = params {
            for (_, value) in params.enumerated() {
                components.queryItems?.append(URLQueryItem(name: value.key, value: value.value))
            }
        }
        
        // Add headers
        request = buildRequestWithHeader(request: request, headers: headers)
        
        // Set dateDecodingStrategy to iso8601 for decoding date format in JSON
        let decoder = JSONDecoder(dateFormat: "yyyy-MM-dd'T'HH:mm:ss.SSSZ")

        
        // Add authorization header if exist
        let preferences = UserDefaults.standard
        let idToken = preferences.string(forKey: "idToken") ?? ""
        request.addValue(idToken, forHTTPHeaderField: "Authorization")
        
        Logger.shared.log("[GET] \(request.debugDescription)\n\(String(describing: request.allHTTPHeaderFields))")
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { output in
                return try self.handleResponse(output)
        }
        .mapError { error in
            return APIError.apiError(reason: error.localizedDescription)
        }
        .decode(type: T.self, decoder: decoder)
        .mapError { error in
            return self.handleDecodeError(error: error)
        }
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
    
    //MARK: -POST-
    func post<T: Decodable>(endpoint: Endpoint, jsonObject: [String: String]? = nil, headers: [String: String]? = nil) -> AnyPublisher<T, Error> {
        
        let queryURL = baseURL.appendingPathComponent(endpoint.path())
        let components = URLComponents(url: queryURL, resolvingAgainstBaseURL: true)!
        var request = URLRequest(url: components.url!)
        request.httpMethod = "POST"

        
        // Add JSON body
        if let jsonObject = jsonObject {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: jsonObject, options: JSONSerialization.WritingOptions())
            } catch let error{
                print(error)
            }
        }
        
        // Add headers
        request = buildPostRequestWithHeader(request: request, headers: headers)
        
        // Set dateDecodingStrategy to iso8601 for decoding date format in JSON
        let decoder = JSONDecoder(dateFormat: "yyyy-MM-dd'T'HH:mm:ss.SSSZ")
        
        Logger.shared.log("[POST] \(request.debugDescription)\n\(String(describing: request.allHTTPHeaderFields))")
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { output in
                return try self.handleResponse(output)
        }
        .mapError { error in
            return APIError.apiError(reason: error.localizedDescription)
        }
        .decode(type: T.self, decoder: decoder)
        .mapError { error in
            return self.handleDecodeError(error: error)
        }
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
    
    private func buildRequestWithHeader(request: URLRequest, headers: [String: String]?) -> URLRequest {
        var request = request
        if let headers = headers {
            for (key, value) in headers {
                request.addValue(value, forHTTPHeaderField: key)
            }
        }
        return request
    }
    
    private func buildPostRequestWithHeader(request: URLRequest, headers: [String: String]?) -> URLRequest {
        var request = request
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        return buildRequestWithHeader(request: request, headers: headers)
    }
    
    private func buildJSONDecoderWithDateFromat(dateFormat: String) -> JSONDecoder {
        let decoder = JSONDecoder()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        return decoder
    }
    
    private func handleResponse(_ output: URLSession.DataTaskPublisher.Output) throws -> Data {
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
    
    private func handleDecodeError(error: Error) -> APIError {
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
    
    func handleReceiveCompletion(_ completion: Subscribers.Completion<Error>) {
        switch completion {
        case .finished:
            break
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
}
