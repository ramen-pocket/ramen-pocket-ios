//
//  ProfileView.swift
//  ramen-pocket
//
//  Created by 陳威任 on 2020/5/24.
//  Copyright © 2020 姚韋辰. All rights reserved.
//

import SwiftUI
import Combine

struct ProfileView: View {
    @EnvironmentObject private var appState: AppState
    @State private var cancellable: AnyCancellable?
    
    var body: some View {
        NavigationView {
            VStack(spacing: 8) {
                CardView {
                    HStack {
                        VStack (alignment: .leading, spacing: 4) {
                            Text(appState.profile.name)
                                .fontWeight(.black)
                                .font(.system(size: 24))
                            Text("積分：\(appState.profile.points)")
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
                    .padding(12)
                }
                .padding(.bottom, 32)
                .frame(maxHeight: 100)
                
                CardView {
                    VStack {
                        PanelItemView(label: "我的收藏", icon: Image("collections"), iconColor: Color(hex: "#3CBCF7"), destination: CollectionsView())
                        PanelItemView(label: "歷史評論", icon: Image("comments"), iconColor: Color(hex: "#FAC61D"), destination: CommentsView())
                        PanelItemView(label: "喜好管理", icon: Image("heart"), iconColor: Color(hex: "#CB4042"), destination: TagManagementView())
                        PanelItemView(label: "設定", icon: Image("settings"), iconColor: Color(hex: "#3BB975"), destination: SettingsView())
                        PanelItemView(label: "登出",
                                      icon: Image("log-out"),
                                      iconColor: Color(hex: "#404040"),
                                      destination: EmptyView()
                                        .onAppear() {
                                            self.appState.idToken = ""
                            }
                        )
                        
                        Spacer()
                    }
                }
                Spacer()
            }
            .padding()
            .navigationBarTitle("個人")
        }
        .onAppear() {
            self.appState.showLoadingIndicator()
            self.cancellable = APIService.shared.profile(idToken: self.appState.idToken)
                .sink(receiveCompletion: { (completion) in
                    APIService.shared.handleReceiveCompletion(completion)
                    self.appState.hideLoadingIndicator()
                }) { (profile: Profile) in
                    self.appState.profile = profile
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
