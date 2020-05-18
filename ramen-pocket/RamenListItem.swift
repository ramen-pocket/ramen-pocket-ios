//
//  RamenListItem.swift
//  ramen-pocket
//
//  Created by 姚韋辰 on 2020/5/15.
//  Copyright © 2020 姚韋辰. All rights reserved.
//

import SwiftUI

struct RamenListItem: View {
    
    let ramen: Ramen
    
    var body: some View {
        HStack(alignment: .top, spacing: 24) {
            Image(ramen.image)
                .resizable()
                .scaledToFill()
                .frame(width: 100, height: 100)
                .clipped()
                .cornerRadius(16, antialiased: true)
            
            VStack(alignment: .leading,spacing: 8) {
                Text(ramen.name)
                    .font(.system(size: 22))
                    .bold()
                    .lineLimit(1)
                
                HStack {
                   Image("dot")
                   Text("營業中").font(.system(size: 16))
                }
                HStack {
                    Image("location")
                    Text(ramen.location).font(.system(size: 16))
                }
                
                HStack {
                    Image("info")
                    Text("\(ramen.price), \(ramen.tag.joined(separator: ", "))").font(.system(size: 16))
                }

            }
            Spacer()
        }
    }
}

struct RamenListItem_Previews: PreviewProvider {
    static let ramen: Ramen = Ramen(name: "五之神", location: "台北市, 信義區", image: "Ramen1", openTime: ["11:00~15:00", "17:00~22:00"], price: "$$", tag: ["日式", "蝦味"])
    
    static var previews: some View {
        RamenListItem(ramen: ramen)
    }
}
