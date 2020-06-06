//
//  RamenListItem.swift
//  ramen-pocket
//
//  Created by 姚韋辰 on 2020/5/15.
//  Copyright © 2020 姚韋辰. All rights reserved.
//

import SwiftUI

struct RamenListItem: View {
    
    let store: Store
    
    var body: some View {
        HStack(alignment: .top, spacing: 24) {
            Image(store.featuredImage)
                .resizable()
                .scaledToFill()
                .frame(width: 108, height: 108)
                .clipped()
                .cornerRadius(16, antialiased: true)
            
            VStack(alignment: .leading,spacing: 8) {
                Text(store.name)
                    .font(.system(size: 22))
                    .bold()
                    .lineLimit(1)
                
                HStack {
                   Image("dot")
                   Text("營業中").font(.system(size: 16))
                }
                HStack {
                    Image("location")
                    Text(store.location.address).font(.system(size: 16))
                }
                
//                HStack {
//                    Image("info")
//                    Text("\(store.price), \(ramen.tags.joined(separator: ", "))").font(.system(size: 16))
//                }

            }
            Spacer()
        }
    }
}

struct RamenListItem_Previews: PreviewProvider {
    
    static let store: Store = Store(id: 1, name: "", isDeleted: false, isCollected: true, location: Location(address: "", lat: 0, lng: 0), rate: 5, featuredImage: "", images: [""], businessHours: [], courses: [])
    
    static var previews: some View {
        RamenListItem(store: store)
    }
}
