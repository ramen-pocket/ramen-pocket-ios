//
//  ImageView.swift
//  ramen-pocket
//
//  Created by 姚韋辰 on 2020/6/6.
//  Copyright © 2020 姚韋辰. All rights reserved.
//

import SwiftUI

struct ImageView: View {
    
    @ObservedObject var imageLoader: ImageLoader
    @State var image: UIImage = UIImage()
    
    private var width: CGFloat;
    private var height: CGFloat;
    private var cornerRadius: CGFloat
    
    init(withurl url: String, width: CGFloat = .infinity, height: CGFloat = .infinity, cornerRadius: CGFloat = 0) {
        imageLoader = ImageLoader(imageURL: url)
        self.width = width;
        self.height = height;
        self.cornerRadius = cornerRadius
    }
    
    var body: some View {
        VStack {
            Image(uiImage: image)
                .resizable()
                .scaledToFill()
                .frame(maxWidth: width, maxHeight: height)
                .clipped()
                .cornerRadius(cornerRadius, antialiased: true)
        }.onReceive(imageLoader.didChange) { data in
            self.image = UIImage(data: data) ?? UIImage()
        }
    }
    
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView(withurl: "https://megapx-assets.dcard.tw/images/cb42c64a-e64c-483e-9753-d5003277f176/160.jpeg")
    }
}
