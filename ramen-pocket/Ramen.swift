//
//  Ramen.swift
//  ramen-pocket
//
//  Created by 姚韋辰 on 2020/5/15.
//  Copyright © 2020 姚韋辰. All rights reserved.
//

import Foundation

struct Ramen: Identifiable {
    let id = UUID()

    let name: String
    let location: String
    let image: String
    let openTime: [String]
    let price: String
    let tag: [String]
}
