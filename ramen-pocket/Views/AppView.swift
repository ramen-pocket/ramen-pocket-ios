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
    
    init() {
//        UITabBar.appearance().barTintColor = UIColor.white
    }
    
    var body: some View {
        VStack {
            TabView(selection: $selectedTab) {
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
    }
}

extension UINavigationBar {
    open override func sizeThatFits(_ size: CGSize) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 20)
    }
}
