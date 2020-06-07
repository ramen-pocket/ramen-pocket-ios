//
//  ImageView.swift
//  ramen-pocket
//
//  Created by 姚韋辰 on 2020/6/6.
//  Copyright © 2020 姚韋辰. All rights reserved.
//

import SwiftUI

struct RemoteImageView: View {
    
    @ObservedObject var imageLoader: ImageLoader
    @State var image: UIImage = UIImage()
    var width: CGFloat = 84
    var height: CGFloat = 84
    
    init(withurl url: String) {
        imageLoader = ImageLoader(imageURL: url)
    }
    
    var body: some View {
        VStack {
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: width, height: width)
                .clipped()
        }.onReceive(imageLoader.didChange) { data in
            self.image = UIImage(data: data) ?? UIImage()
        }
    }
    
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        RemoteImageView(withurl: "https://megapx-assets.dcard.tw/images/cb42c64a-e64c-483e-9753-d5003277f176/160.jpeg")
    }
}
