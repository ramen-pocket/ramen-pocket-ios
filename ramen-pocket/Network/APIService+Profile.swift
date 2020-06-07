//
//  APIService+Login.swift
//  ramen-pocket
//
//  Created by 姚韋辰 on 2020/6/1.
//  Copyright © 2020 姚韋辰. All rights reserved.
//

import Foundation
import Combine

extension APIService {
    
    func profile(idToken: String) -> AnyPublisher<Profile, Error> {
        return self.get(endpoint: .userProfile())
    }
}
