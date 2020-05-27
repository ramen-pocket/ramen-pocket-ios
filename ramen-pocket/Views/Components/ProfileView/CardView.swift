//
//  CardView.swift
//  ramen-pocket
//
//  Created by 陳威任 on 2020/5/27.
//  Copyright © 2020 姚韋辰. All rights reserved.
//

import SwiftUI

struct CardView<Content: View>: View {
    let content: Content
    init(content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color(.white))
                    .shadow(color: Color(.sRGB, hex: "#000000", opacity: 0.1), radius: 3, x: 2, y: 2)
                VStack {
                    self.content
                }
                .padding()
                .cornerRadius(1)
            }
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView {
            Text("Just a text")
        }
    }
}
