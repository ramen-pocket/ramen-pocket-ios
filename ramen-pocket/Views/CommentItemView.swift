//
//  CommentItem.swift
//  ramen-pocket
//
//  Created by 姚韋辰 on 2020/5/18.
//  Copyright © 2020 姚韋辰. All rights reserved.
//

import SwiftUI

struct CommentItem: View {
    
    let author: String
    let message: String
    
    var body: some View {
        HStack {
            Image("Ramen1")
                .resizable()
                .scaledToFill()
                .frame(width: 80, height: 80)
                .clipShape(Circle())
            VStack(alignment: .leading) {
                Text(author)
                    .font(.system(size: 22))
                    .padding(.bottom, 8)
                Text(message)
                    .foregroundColor(.secondary)
            }
            .padding(.horizontal)
            Spacer()
            
        }
    }
}

struct CommentItem_Previews: PreviewProvider {
    static var previews: some View {
        CommentItem(author: "DevilTea", message: "蝦味很濃，真心推")
    }
}
