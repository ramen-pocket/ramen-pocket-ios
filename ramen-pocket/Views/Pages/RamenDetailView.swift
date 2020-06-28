//
//  RamenDetailView.swift
//  ramen-pocket
//
//  Created by 姚韋辰 on 2020/5/15.
//  Copyright © 2020 姚韋辰. All rights reserved.
//

import SwiftUI
import Combine

struct RamenDetailView: View {
    
    var store: Store
    let dayOfWeek = ["星期一", "星期二", "星期三", "星期四", "星期五", "星期六", "星期日"]
    
    @EnvironmentObject var appState: AppState
    
    @State var showCopySuccesAlert: Bool = false
    @State var comments: [Comment] = []
    @State private var cancellable: AnyCancellable?
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                buildImage()
                
                buildTitleSection()
                
                buildOpeningTimeSection()
                
                buildAddressSection()
                
                buildCommentSection()
                
                buildPhotoSection()
            }
        }
        .navigationBarTitle("", displayMode: .inline)
        .onAppear {
            self.fetchStoreComment()
        }
    }
    
    func buildImage() -> some View {
        ImageView(withurl: "\(store.featuredImage)", height: 200)
    }
    
    func buildTitleSection() -> some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(alignment: .top) {
                Text(store.name)
                    .font(.system(size: 36))
                    .bold()
                
                Spacer()
                Text(String(format:"%.1lf", store.rate))
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
                    Text("\(self.dayOfWeek[index])：\(self.getOpeningTimeofDay(index))")
                        .padding(.bottom, 8)
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .topLeading)
        .padding()
    }
    
    func getOpeningTimeofDay(_ index: Int) -> String {
        if (self.store.businessHours.indices.contains(index)) {
            if (self.store.businessHours[index].off) {
                return "休息"
            } else {
                return "\(self.store.businessHours[index].begin) ~ \(self.store.businessHours[index].end)"
            }
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
            Text(store.location.address)
            Text("複製地址")
                .foregroundColor(.red)
                .onTapGesture {
                    UIPasteboard.general.string = self.store.location.address
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
                Text("(\(comments.count) 則)")
                Spacer()
                NavigationLink(destination: RamenCommentsView(comments: comments)) {
                    Text("查看所有評論")
                        .foregroundColor(.red)
                }
                
            }
            NavigationLink(destination: AddCommentView(storeId: store.id)) {
                Text("我要評論")
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .font(.system(size: 18))
                    .foregroundColor(Color.init(hex: "#333333"))
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(Color.init(hex: "#333333"), lineWidth: 2)
                )
            }
            //            CommentItem(author: "DevilTea", message: "蝦味很濃，值得一試")
            
        }
        .frame(maxWidth: .infinity, alignment: .topLeading)
        .padding()
    }
    
    func buildPhotoSection() -> some View {
        VStack(alignment: .leading) {
            HStack {
                Text("拉麵照片")
                    .font(.system(size: 24))
                    .bold()
                Text("(\(store.images.count) 張)")
                Spacer()
                NavigationLink(destination: RamenImagesView(images: store.images)) {
                    Text("查看所有照片")
                        .foregroundColor(.red)
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .topLeading)
        .padding()
        .background(Color.white)
    }
    
    func fetchStoreComment() {
        self.appState.showLoadingIndicator()
        self.cancellable = APIService.shared.storeComments(self.store.id)
            .sink(receiveCompletion: { (completion) in
                APIService.shared.handleReceiveCompletion(completion)
                self.appState.hideLoadingIndicator()
            }) { (commentResponse) in
                self.comments = commentResponse.comments
        }
    }
}

struct RamenDetailView_Previews: PreviewProvider {
    
    static let store: Store = Store(id: 1, name: "", isCollected: true, location: Location(address: "", lat: 0, lng: 0), rate: 5, featuredImage: "", images: [""], businessHours: [], courses: [])
    
    static var previews: some View {
        RamenDetailView(store: store).environmentObject(AppState())
    }
}
