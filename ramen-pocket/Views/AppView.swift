//
//  ContentView.swift
//  ramen-pocket
//
//  Created by 姚韋辰 on 2020/4/15.
//  Copyright © 2020 姚韋辰. All rights reserved.
//

import SwiftUI

struct AppView: View {
    
    @State var selectedTab = 0
    @State var isLoading = true
    
    @EnvironmentObject var appState: AppState
    
    let loginView = LoginView()
    
    init() {
        //        UITabBar.appearance().barTintColor = UIColor.white
    }
    
    var body: some View {
        ActivityIndicatorView() {
            Group {
                if !self.appState.isLogin {
                    self.loginView
                } else {
                    VStack {
                        TabView(selection: self.$selectedTab) {
                            RamenListView()
                                .tabItem {
                                    Image("explore").renderingMode(.template)
                                    Text("探索")
                            }
                            .tag(0)
                            
                            PlanningView()
                                .tabItem {
                                    Image("plan").renderingMode(.template)
                                    Text("計畫")
                            }
                            .tag(1)
                            
                            ProfileView()
                                .tabItem {
                                    Image("profile").renderingMode(.template)
                                    Text("個人")
                            }
                            .tag(2)
                        }
                        .accentColor(.red)
                        
                        Spacer()
                    }
                }
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static let appState = (UIApplication.shared.delegate as! AppDelegate).appState
    
    static var previews: some View {
        AppView()
            .environmentObject(appState)
    }
}

extension UINavigationBar {
    open override func sizeThatFits(_ size: CGSize) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 20)
    }
}
