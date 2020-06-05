//
//  SelectRamenStore.swift
//  ramen-pocket
//
//  Created by Aaron Xue on 2020/5/28.
//  Copyright © 2020 姚韋辰. All rights reserved.
//

import SwiftUI

struct SearchBar: UIViewRepresentable {
    
    @Binding var text: String
    var placeholder: String
    
    class Coordinator: NSObject, UISearchBarDelegate {
        
        @Binding var text: String
        
        init(text: Binding<String>) {
            _text = text
        }
        
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            text = searchText
        }
    }
    
    func makeCoordinator() -> SearchBar.Coordinator {
        return Coordinator(text: $text)
    }
    
    func makeUIView(context: UIViewRepresentableContext<SearchBar>) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        searchBar.placeholder = placeholder
        searchBar.searchBarStyle = .minimal
        searchBar.autocapitalizationType = .none
        return searchBar
    }
    
    func updateUIView(_ uiView: UISearchBar, context: UIViewRepresentableContext<SearchBar>) {
        uiView.text = text
    }
}

struct SelectRamenStoreView: View {
    var sheetState: SheetState
    
    let datas = ["五之神", "鳥人拉麵 中山店", "麵屋壹慶", "五之神製作所 台灣", "鷹流拉麵 台灣本店", "Okaeri お帰り 你回來啦拉麵", "麵屋牛一雞骨牛肉麵", "雞二拉麵", "五之神", "鳥人拉麵 中山店", "麵屋壹慶", "五之神製作所 台灣", "鷹流拉麵 台灣本店", "Okaeri お帰り 你回來啦拉麵", "麵屋牛一雞骨牛肉麵", "雞二拉麵"]
    
    @State private var searchText = ""
    
    var body: some View {
        VStack {
            SearchBar(text: $searchText, placeholder: "Search")
            List {
                ForEach(self.datas.filter {
                    self.searchText.isEmpty ? true : $0.lowercased().contains(self.searchText.lowercased())
                }, id: \.self) { data in
                    NavigationLink(destination: SelectDateView(sheetState: self.sheetState)
                        .navigationBarItems(trailing:
                            HStack {
                                Button("上一頁") {
                                    self.sheetState.activeSheet = ActiveSheet.storeSheet
                                }
                        })) {
                            Text(data)
                    }
                }
            }
        }
    }
}
