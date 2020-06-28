//
//  PostStore.swift
//  ramen-pocket
//
//  Created by 姚韋辰 on 2020/6/24.
//  Copyright © 2020 姚韋辰. All rights reserved.
//

import Foundation

// MARK: - Store
struct PostComment: Codable {
    let content: String?
    let rate: Int?
}
