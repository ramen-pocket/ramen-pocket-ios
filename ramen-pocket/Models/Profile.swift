//
//  Profile.swift
//  ramen-pocket
//
//  Created by 姚韋辰 on 2020/6/1.
//  Copyright © 2020 姚韋辰. All rights reserved.
//

import Foundation

struct Profile: Decodable {
    let userId: String
    let name: String
    let avatar: String
    let points: Int
}
