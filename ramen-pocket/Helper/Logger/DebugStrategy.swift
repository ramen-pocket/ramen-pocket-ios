//
//  LowercaseStrategy.swift
//  ramen-pocket
//
//  Created by 姚韋辰 on 2020/6/8.
//  Copyright © 2020 姚韋辰. All rights reserved.
//

struct DebugDescriptionStrategy: LoggerStrategy {
    func log(_ message: String) {
        print(message.debugDescription)
    }
}
