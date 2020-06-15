//
//  JSONDecoderExtension.swift
//  ramen-pocket
//
//  Created by 姚韋辰 on 2020/6/13.
//  Copyright © 2020 姚韋辰. All rights reserved.
//

import Foundation

extension JSONDecoder {
    
    convenience init(dateFormat: String) {
        self.init()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        self.dateDecodingStrategy = .formatted(dateFormatter)
    }
}
