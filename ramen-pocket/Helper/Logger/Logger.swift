//
//  Logger.swift
//  ramen-pocket
//
//  Created by 姚韋辰 on 2020/6/8.
//  Copyright © 2020 姚韋辰. All rights reserved.
//

struct Logger {
    static let shared = Logger()
    
    var strategy: LoggerStrategy = NormalStrategy()
    
    private init() {}
    
    func log(_ message: String) {
        strategy.log(message)
    }
}
