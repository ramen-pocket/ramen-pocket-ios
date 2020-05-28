//
//  Planning.swift
//  ramen-pocket
//
//  Created by Aaron Xue on 2020/5/28.
//  Copyright © 2020 姚韋辰. All rights reserved.
//

import Foundation

struct Plan: Identifiable {
    let id = UUID()

    let name: String
    let image: String
    let bookDate: String
    let isExpired: Bool
}
