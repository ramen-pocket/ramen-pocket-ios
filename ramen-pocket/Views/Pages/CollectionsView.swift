//
//  CollectionsView.swift
//  ramen-pocket
//
//  Created by 陳威任 on 2020/5/28.
//  Copyright © 2020 姚韋辰. All rights reserved.
//

import SwiftUI
import Combine

struct CollectionsView: View {
    
    @EnvironmentObject var appState: AppState
    @State private var stores: [Store] = []
    @State private var cancellable: AnyCancellable?
        
    var body: some View {
        RamenListView(stores: stores)
            .navigationBarTitle("我的收藏")
            .onAppear {
                self.appState.showLoadingIndicator()
                self.cancellable = APIService.shared.userCollections()
                    .sink(receiveCompletion: { (completion) in
                        APIService.shared.handleReceiveCompletion(completion)
                        self.appState.hideLoadingIndicator()
                    }) { (storeResponse: StoreResponse) in
                        self.stores = storeResponse.stores
                }
        }
    }
}

struct CollectionsView_Previews: PreviewProvider {
    static var previews: some View {
        CollectionsView()
    }
}
