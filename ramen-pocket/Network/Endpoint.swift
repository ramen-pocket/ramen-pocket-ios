//
//  Endpoint.swift
//  ramen-pocket
//
//  Created by 姚韋辰 on 2020/5/28.
//  Copyright © 2020 姚韋辰. All rights reserved.
//

import Foundation

public enum Endpoint {
    
    //MARK: - Store -
    case stores, storeComments(storeId: Int, recordId: Int? = nil)
    
    //MARK: - User -
    case userProfile(userId: Int? = nil)
    case userCollections(storeId: Int? = nil, userId: Int? = nil)
    case userComments(userId: Int? = nil)
}

//MARK: - endpoint extension for url -
extension Endpoint {
        
    func path() -> String {
        
        switch self {
        case .stores:
            return "stores"
        case .storeComments(storeId: let storeId, recordId: let recordId):
            if (recordId == nil) {
                return "stores/\(storeId)/comments"
            } else {
                return "stores/\(String(storeId))/comments/\(String(recordId!))"
            }
        case .userProfile(userId: let userId):
            if (userId != nil) {
                return "user/\(String(userId!))/profile"
            } else {
                return "user/profile"
            }
        case .userCollections(storeId: let storeId, userId: let userId):
            if (storeId != nil && userId == nil) {
                return "user/collections/:storeId"
            } else if (storeId == nil && userId != nil) {
                return "users/:id/collections"
            } else {
                return "users/collections"
            }
        case .userComments(userId: let userId):
            if (userId != nil) {
                return "user/\(String(userId!))/comments"
            } else {
                return "user/comments"
            }
        }
    }
}
