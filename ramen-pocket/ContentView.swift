//
//  ContentView.swift
//  ramen-pocket
//
//  Created by 姚韋辰 on 2020/4/15.
//  Copyright © 2020 姚韋辰. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var selectedTab = 0
    
    init() {
        UITabBar.appearance().barTintColor = UIColor.white
    }
    
    var body: some View {
        VStack {
            TabView(selection: $selectedTab) {
                RamenListView()
                    .tabItem {
                        Image("explore").renderingMode(.template)
                        Text("探索")
                }
                Text("The content of the first view")
                    .tabItem {
                        Image("plan").renderingMode(.template)
                        Text("計畫")
                }
                Text("The content of the second view")
                    .tabItem {
                        Image("profile").renderingMode(.template)
                        Text("個人")
                }
            }
            .accentColor(.red)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
