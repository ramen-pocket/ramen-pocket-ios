//
//  RamenImagesView.swift
//  ramen-pocket
//
//  Created by 姚韋辰 on 2020/6/7.
//  Copyright © 2020 姚韋辰. All rights reserved.
//

import SwiftUI

struct RamenImagesView: View {
    var images: [String]
    
    init(images: [String]) {
        UITableView.appearance().separatorStyle = .none
        self.images = images
    }
    
    var body: some View {
        List(images, id: \.self) { image in
            ImageView(withurl: image, width: .infinity, height: 200)
            .padding(EdgeInsets(top: -8, leading: -16, bottom: 8, trailing: -16))
        }
        .navigationBarTitle("拉麵照片")
    }
}

struct RamenImagesView_Previews: PreviewProvider {
    static var previews: some View {
        RamenImagesView(images: [""])
    }
}
