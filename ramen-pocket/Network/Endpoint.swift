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
    case stores, storeComments(storeId: String, recordId: String = "")
    
    //MARK: - User -
    case userProfile(userId: String = "")
    case userCollections(storeId: String = "", userId: String = "")
    case userComments(userId: String = "")
}

//MARK: - endpoint extension for url -
extension Endpoint {
        
    func path() -> String {
        
        switch self {
        case .stores:
            return "stores"
        case .storeComments(storeId: let storeId, recordId: let recordId):
            if (recordId == "") {
                return "stores/\(storeId)/comments"
            } else {
                return "stores/\(storeId)/comments/\(recordId)"
            }
        case .userProfile(userId: let userId):
            if (userId != "") {
                return "user/\(userId)/profile"
            } else {
                return "user/profile"
            }
        case .userCollections(storeId: let storeId, userId: let userId):
            if (storeId != "" && userId == "") {
                return "user/collections/:storeId"
            } else if (storeId == "" && userId != "") {
                return "users/:id/collections"
            } else {
                return "users/collections"
            }
        case .userComments(userId: let userId):
            if (userId != "") {
                return "user/\(userId)/comments"
            } else {
                return "user/comments"
            }
        }
    }
}
