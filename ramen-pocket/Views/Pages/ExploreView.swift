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
            VStack {
                HStack(spacing: 24) {
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .foregroundColor(Color.init(hex: "#999999"))
                        .frame(width: 64, height: 64)
                        .padding(.horizontal, 22)
                    VStack(alignment: .leading, spacing: 4) {
                        Text("找不到喜歡的拉麵嗎？")
                            .font(.system(size:16))
                            .foregroundColor(Color.init(hex: "#666666"))
                        Text("新增拉麵店")
                            .font(.system(size:16))
                            .foregroundColor(Color.init(hex: "#666666"))
                    }
                    Spacer()
                }
                .padding(.top, 18)
                .padding(.bottom, 18)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.init(hex: "#CCCCCC"), lineWidth: 1)
                )
                .padding(.top, 12)
                .padding(.horizontal, 32)
                                
                RamenListView(stores: stores)
                    .navigationBarTitle("拉麵清單")
            }
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
        ExploreView().environmentObject(AppState())
    }
}
