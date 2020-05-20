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
    
    @State var showCopySuccesAlert: Bool = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                buildImage()
                
                buildTitleSection()
                
                buildOpeningTimeSection()
                
                buildAddressSection()
                
                buildCommentSection()
                
                buildPhotoSection()
                
                Spacer()
            }
            .navigationBarTitle(Text(ramen.name), displayMode: .inline)
        }
        
    }
    
    func buildImage() -> some View {
        Image("\(ramen.image)")
            .resizable()
            .scaledToFill()
            .frame(height: 200)
            .clipped()
    }
    
    func buildTitleSection() -> some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(alignment: .top) {
                Text(ramen.name)
                    .font(.system(size: 36))
                    .bold()
                
                Spacer()
                Text("4.5")
                    .padding(10)
                    .foregroundColor(.white)
                    .background(Color.yellow)
                    .cornerRadius(8)
            }
        }
        .padding()
        .background(Color.white)
    }
    
    func buildOpeningTimeSection() -> some View {
        VStack(alignment: .leading) {
            Text("營業時間")
                .font(.system(size: 24))
                .bold()
                .padding(.bottom)
            Group {
                ForEach(0...6, id: \.self) { index in
                    Text("星期一：\(self.getOpeningTimeofDay(index))")
                        .padding(.bottom, 8)
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .topLeading)
        .padding()
    }
    
    func getOpeningTimeofDay(_ index: Int) -> String {
        if (self.ramen.openingTimes.indices.contains(index)) {
            return self.ramen.openingTimes[index]
        } else {
            return "休息"
        }
    }
    
    func buildAddressSection() -> some View {
        VStack(alignment: .leading) {
            Text("地址")
                .font(.system(size: 24))
                .bold()
                .padding(.bottom)
            Text(ramen.address)
            Text("複製地址")
                .foregroundColor(.red)
                .onTapGesture {
                    UIPasteboard.general.string = self.ramen.address
                    self.showCopySuccesAlert = true
            }
            .padding(.top)
            .alert(isPresented: $showCopySuccesAlert) {
                Alert(title: Text("複製成功"), dismissButton: .default(Text("關閉")))
            }
        }
        .frame(maxWidth: .infinity, alignment: .topLeading)
        .padding()
    }
    
    func buildCommentSection() -> some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("留言評論")
                    .font(.system(size: 24))
                    .bold()
                Spacer()
                Text("查看所有評論")
                    .foregroundColor(.red)
            }
            CommentItem(author: "DevilTea", message: "蝦味很濃，值得一試")
            
        }
        .frame(maxWidth: .infinity, alignment: .topLeading)
        .padding()
    }
    
    func buildPhotoSection() -> some View {
        VStack(alignment: .leading) {
            Text("拉麵照片")
                .font(.system(size: 24))
                .bold()
        }
        .frame(maxWidth: .infinity, alignment: .topLeading)
        .padding()
        .background(Color.white)
    }
}

struct RamenDetailView_Previews: PreviewProvider {
    
    static let ramen: Ramen = Ramen(name: "五之神製麵所", address: "台北市信義區忠孝東路四段553巷6弄6號", image: "Ramen1", openingTimes: ["11:00~15:00", "17:00~22:00", "17:00~22:00", "17:00~22:00", "17:00~22:00", "17:00~22:00", "17:00~22:00"], price: "", tags: ["日式", "蝦味"])
    
    static var previews: some View {
        RamenDetailView(ramen: ramen)
    }
}
