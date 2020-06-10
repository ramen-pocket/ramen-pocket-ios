//
//  RamenAPI.swift
//  ramen-pocket
//
//  Created by 姚韋辰 on 2020/5/27.
//  Copyright © 2020 姚韋辰. All rights reserved.
//

import Foundation
import Combine

extension APIService {
    
    func ramens() -> AnyPublisher<StoreResponse, Error> {
        return self.get(endpoint: .stores)
    }
    
    func userCollections() -> AnyPublisher<StoreResponse, Error> {
        return self.get(endpoint: .userCollections())
    }
}
