//
//  RamenListView.swift
//  ramen-pocket
//
//  Created by 姚韋辰 on 2020/5/15.
//  Copyright © 2020 姚韋辰. All rights reserved.
//

import SwiftUI

struct RamenListView: View {
    let ramens: [Ramen] = [
        Ramen(name: "鳥人拉麵 中山店", address: "台北市, 信義區", image: "Ramen1", openingTimes: ["11:00~15:00", "17:00~22:00"], price: "$$", tags: ["日式", "蝦味"]),
        Ramen(name: "麵屋壹慶", address: "台北市, 信義區", image: "Ramen2", openingTimes: ["11:00~15:00", "17:00~22:00"], price: "$$", tags: ["日式", "蝦味"]),
        Ramen(name: "五之神製作所 台灣", address: "台北市, 信義區", image: "Ramen3", openingTimes: ["11:00~15:00", "17:00~22:00"], price: "$$", tags: ["日式", "蝦味"]),
        Ramen(name: "鷹流拉麵 台灣本店", address: "台北市, 信義區", image: "Ramen4", openingTimes: ["11:00~15:00", "17:00~22:00"], price: "$$", tags: ["日式", "蝦味"]),
        Ramen(name: "Okaeri お帰り 你回來啦拉麵", address: "台北市, 信義區", image: "Ramen5", openingTimes: ["11:00~15:00", "17:00~22:00"], price: "$$", tags: ["日式", "蝦味"]),
        Ramen(name: "麵屋牛一雞骨牛肉麵", address: "台北市, 信義區", image: "Ramen6", openingTimes: ["11:00~15:00", "17:00~22:00"], price: "$$", tags: ["日式", "蝦味"]),
        Ramen(name: "雞二拉麵", address: "台北市, 信義區", image: "Ramen7", openingTimes: ["11:00~15:00", "17:00~22:00"], price: "$$", tags: ["日式", "蝦味"])
    ]
    
    var body: some View {
        NavigationView {
            List(ramens) { ramen in
                NavigationLink(destination: RamenDetailView(ramen: ramen)) {
                    RamenListItem(ramen: ramen).padding(12)
                }
            }
            .navigationBarTitle("拉麵清單")
        }
    }
}

struct RamenListView_Previews: PreviewProvider {

    static var previews: some View {
        RamenListView()
    }
}
