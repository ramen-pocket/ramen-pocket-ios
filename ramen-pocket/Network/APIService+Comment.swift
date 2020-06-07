//
//  APIService+Comment.swift
//  ramen-pocket
//
//  Created by 姚韋辰 on 2020/6/8.
//  Copyright © 2020 姚韋辰. All rights reserved.
//

import Combine

extension APIService {
    
    func storeComments(_ storeId: Int) -> AnyPublisher<CommentResponse, Error> {
        return self.get(endpoint: .storeComments(storeId: storeId))
    }
    
}
