//
//  RamenListView.swift
//  ramen-pocket
//
//  Created by 姚韋辰 on 2020/5/15.
//  Copyright © 2020 姚韋辰. All rights reserved.
//

import SwiftUI
import Combine

struct RamenListView: View {
    
    @EnvironmentObject private var appState: AppState
    
    @State private var cancellable: AnyCancellable?
    @State private var stores: [Store] = []
    
    init() {
        UITableView.appearance().tableFooterView = UIView()
        UITableView.appearance().separatorStyle = .none
    }
    
    var body: some View {
        NavigationView {
            List(stores) { store in
                NavigationLink(destination: RamenDetailView(store: store)) {
                    RamenListItem(store: store).padding(12)
                }
            }
            .navigationBarTitle("拉麵清單")
        }
        .onAppear {
            self.appState.showLoadingIndicator()
            self.cancellable = APIService.shared
                .get(endpoint: .stores)
                .sink(receiveCompletion: { (completion) in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                    self.appState.hideLoadingIndicator()
                }) { (storeResponse: StoreResponse) in
                    self.stores = storeResponse.stores
                }
        }
    }
}

struct RamenListView_Previews: PreviewProvider {

    static var previews: some View {
        RamenListView()
    }
}
