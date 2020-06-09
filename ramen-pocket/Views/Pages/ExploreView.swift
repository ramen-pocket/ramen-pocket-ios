//
//  ExploreView.swift
//  ramen-pocket
//
//  Created by 姚韋辰 on 2020/5/15.
//  Copyright © 2020 姚韋辰. All rights reserved.
//

import SwiftUI
import Combine

struct ExploreView: View {
    
    @EnvironmentObject private var appState: AppState
    
    @State private var cancellable: AnyCancellable?
    @State private var stores: [Store] = []
    
    init() {
        UITableView.appearance().tableFooterView = UIView()
        UITableView.appearance().separatorStyle = .none
    }
    
    var body: some View {
        NavigationView {
            RamenListView(stores: stores)
                .navigationBarTitle("拉麵清單")
        }
        .onAppear {
            self.appState.showLoadingIndicator()
            self.cancellable = APIService.shared
                .get(endpoint: .stores)
                .sink(receiveCompletion: { (completion) in
                    APIService.shared.handleReceiveCompletion(completion)
                    self.appState.hideLoadingIndicator()
                }) { (storeResponse: StoreResponse) in
                    self.stores = storeResponse.stores
            }
        }
    }
}

struct ExploreView_Previews: PreviewProvider {
    
    static var previews: some View {
        ExploreView()
    }
}
