//
//  PanelItemView.swift
//  ramen-pocket
//
//  Created by 陳威任 on 2020/5/27.
//  Copyright © 2020 姚韋辰. All rights reserved.
//

import SwiftUI

struct PanelItemView<Destination: View>: View {
    let label: String
    let icon: Image
    let iconColor: Color
    let destination: Destination
    
    var body: some View {
        NavigationLink(destination: self.destination) {
            HStack {
                self.icon
                    .resizable()
                    .scaledToFit()
                    .accentColor(self.iconColor)
                    .frame(width: 24, height: 24)
                    .padding([.trailing], 8)
                Text(self.label)
                    .font(.system(size: 20))
                    .accentColor(Color(hex: "#333333"))
                Spacer()
            }
            .padding(4)
        }
    }
}
