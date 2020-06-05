//
//  Ramen.swift
//  ramen-pocket
//
//  Created by 姚韋辰 on 2020/5/15.
//  Copyright © 2020 姚韋辰. All rights reserved.
//

import Foundation

struct Ramen: Decodable, Identifiable {
    let id = UUID()
    let name: String
    let address: String
    let image: String
    let openingTimes: [String]
    let price: String
    let tags: [String]
}
