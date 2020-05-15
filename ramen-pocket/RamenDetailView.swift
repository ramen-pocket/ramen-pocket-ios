//
//  RamenDetailView.swift
//  ramen-pocket
//
//  Created by 姚韋辰 on 2020/5/15.
//  Copyright © 2020 姚韋辰. All rights reserved.
//

import SwiftUI

struct RamenDetailView: View {
    
    var ramen: Ramen

    var body: some View {
        VStack(alignment: .leading) {
            Image("\(ramen.image)")
                .resizable()
                .scaledToFill()
                .frame(height: 200)
                .clipped()
            
            VStack(alignment: .leading, spacing: 8) {
                Text("地址").bold().font(.system(size: 20))
                Text(ramen.location).foregroundColor(.secondary).font(.system(size: 18))
            }
            .frame(maxWidth: .infinity)
            .padding()
            
            Spacer()
        }
        .navigationBarTitle(Text(ramen.name), displayMode: .inline)
    }
}

struct RamenDetailView_Previews: PreviewProvider {
    
    static let ramen: Ramen = Ramen(name: "五之神", location: "10491台北市中山區中山北路一段105巷7號", image: "Ramen1", openTime: ["11:00~15:00", "17:00~22:00"], price: "", tag: ["日式", "蝦味"])
    
    static var previews: some View {
        RamenDetailView(ramen: ramen)
    }
}
