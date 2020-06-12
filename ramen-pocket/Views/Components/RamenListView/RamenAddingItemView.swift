//
//  RamenAddingItemView.swift
//  ramen-pocket
//
//  Created by 姚韋辰 on 2020/6/12.
//  Copyright © 2020 姚韋辰. All rights reserved.
//

import SwiftUI

struct RamenAddingItemView: View {
    var body: some View {
        HStack(spacing: 24) {
            Image(systemName: "plus.circle.fill")
                .resizable()
                .foregroundColor(Color.init(hex: "#999999"))
                .frame(width: 64, height: 64)
                .padding(.horizontal, 22)
            VStack(alignment: .leading, spacing: 4) {
                Text("找不到喜歡的拉麵嗎？")
                    .font(.system(size:16))
                    .foregroundColor(Color.init(hex: "#666666"))
                Text("新增拉麵店")
                    .font(.system(size:16))
                    .foregroundColor(Color.init(hex: "#666666"))
            }
            Spacer()
        }
        .padding(.top, 18)
        .padding(.bottom, 18)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.init(hex: "#CCCCCC"), lineWidth: 1)
        )
        .padding(.horizontal, 12)
    }
}

struct RamenAddingItemView_Previews: PreviewProvider {
    static var previews: some View {
        RamenAddingItemView()
    }
}
