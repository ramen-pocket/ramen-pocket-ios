//
//  Color+Hex.swift
//  ramen-pocket
//
//  Created by 陳威任 on 2020/5/27.
//  Copyright © 2020 姚韋辰. All rights reserved.
//

import SwiftUI

struct RGB {
    let red: Double
    let green: Double
    let blue: Double
}

func isValidHex(hex: String) -> Bool {
   return hex.range(of: #"#[a-fA-F0-9]{6,6}"#, options: .regularExpression) != nil
}

func hexToDoubleRGB(hex: String) -> RGB {
    let red: Double = Double(Int(hex.substring(with: 1..<3), radix: 16)!)/255
    let green: Double = Double(Int(hex.substring(with: 3..<5), radix: 16)!)/255
    let blue: Double = Double(Int(hex.substring(with: 5..<7), radix: 16)!)/255
    return RGB(red: red, green: green, blue: blue)
}

extension Color {
    init (hex: String) {
        if !isValidHex(hex: hex) {
            self.init(red: 0, green: 0, blue: 0)
            return
        }
        let rgb: RGB = hexToDoubleRGB(hex: hex)
        self.init(red: rgb.red, green: rgb.green, blue: rgb.blue)
    }
    
    init (_ colorSpace: RGBColorSpace, hex: String, opacity: Double) {
        if !isValidHex(hex: hex) {
            self.init(colorSpace, red: 0, green: 0, blue: 0, opacity: opacity)
            return
        }
        let rgb: RGB = hexToDoubleRGB(hex: hex)
        self.init(colorSpace, red: rgb.red, green: rgb.green, blue: rgb.blue, opacity: opacity)
    }
}
