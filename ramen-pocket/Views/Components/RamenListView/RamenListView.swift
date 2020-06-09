//
//  RamenListView.swift
//  ramen-pocket
//
//  Created by 姚韋辰 on 2020/6/9.
//  Copyright © 2020 姚韋辰. All rights reserved.
//

import SwiftUI

struct RamenListView: View {
    
    var stores: [Store] = []
    
    var body: some View {
        List(stores) { store in
            NavigationLink(destination: RamenDetailView(store: store)) {
                RamenListItem(store: store).padding(12)
            }
        }
    }
}

struct RamenListView_Previews: PreviewProvider {
    static var previews: some View {
        RamenListView(stores: [])
    }
}
