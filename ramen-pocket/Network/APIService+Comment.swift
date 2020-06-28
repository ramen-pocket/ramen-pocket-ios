//
//  APIService+Comment.swift
//  ramen-pocket
//
//  Created by 姚韋辰 on 2020/6/8.
//  Copyright © 2020 姚韋辰. All rights reserved.
//

import Combine
import Foundation

extension APIService {
    
    func storeComments(_ storeId: Int) -> AnyPublisher<CommentResponse, Error> {
        return self.get(endpoint: .storeComments(storeId: storeId))
    }
    
    func postStoreComment(_ storeId: Int, postComment: PostComment) -> AnyPublisher<Data, Error> {
        do {
            let jsonEncoder = JSONEncoder()
            let jsonData = try jsonEncoder.encode(postComment)
            return self.post(endpoint: .storeComments(storeId: storeId), jsonData: jsonData)

        } catch let error {
            print(error)
            return self.post(endpoint: .storeComments(storeId: storeId))
        }

    }
}
