//
//  UppercaseStratgy.swift
//  ramen-pocket
//
//  Created by 姚韋辰 on 2020/6/8.
//  Copyright © 2020 姚韋辰. All rights reserved.
//

struct NormalStratgy: LoggerStrategy {
    func log(_ message: String) {
        print(message.description)
    }
}
