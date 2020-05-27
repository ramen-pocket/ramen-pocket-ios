//
//  ProfileView.swift
//  ramen-pocket
//
//  Created by 陳威任 on 2020/5/24.
//  Copyright © 2020 姚韋辰. All rights reserved.
//

import SwiftUI

struct ProfileView: View {
    
    var body: some View {
        NavigationView {
            VStack(spacing: 8) {
                CardView {
                    HStack {
                        VStack (alignment: .leading, spacing: 4) {
                            Text("名字字")
                                .fontWeight(.black)
                                .font(.system(size: 24))
                            Text("厲害的稱號")
                                .fontWeight(.light)
                                .font(.system(size: 14))
                                .foregroundColor(Color(hex: "#aaaaaa"))
                        }
                        Spacer()
                        Image("profile")
                            .resizable()
                            .scaledToFill()
                            .padding(12)
                            .frame(width: 56, height: 56)
                            .background(Color(hex: "#b3e5fc"))
                            .cornerRadius(28)
                            .clipped()
                    }
                }
                .frame(maxHeight: 100)
                
                CardView {
                    VStack {
                        PanelItemView(label: "我的收藏", icon: Image("collections"), iconColor: Color(hex: "#3CBCF7"), destination: CollectionsView())
                        PanelItemView(label: "歷史評論", icon: Image("comments"), iconColor: Color(hex: "#FAC61D"), destination: CommentsView())
                        PanelItemView(label: "喜好管理", icon: Image("heart"), iconColor: Color(hex: "#CB4042"), destination: TagManagementView())
                        PanelItemView(label: "設定", icon: Image("settings"), iconColor: Color(hex: "#404040"), destination: SettingsView())
                        Spacer()
                    }
                }
                Spacer()
            }
            .padding()
            .navigationBarTitle("個人")
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
