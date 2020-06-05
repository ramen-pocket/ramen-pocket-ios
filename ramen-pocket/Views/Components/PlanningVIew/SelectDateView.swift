//
//  SelectDateView.swift
//  ramen-pocket
//
//  Created by Aaron Xue on 2020/5/28.
//  Copyright © 2020 姚韋辰. All rights reserved.
//

import SwiftUI

struct SelectDateView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var rkCalender: RKManager = RKManager(calendar: Calendar.current, minimumDate: Date(), maximumDate: Date().addingTimeInterval(60*60*24*365*2), mode: 0)
    
    var sheetState: SheetState
    
    var body: some View {
        NavigationView {
            VStack {
                RKViewController(isPresented: .constant(false), rkManager: rkCalender)
            }
            .padding(.all, 20)
            .navigationBarItems(trailing:
                HStack{
                    Button("上一頁"){
                        self.sheetState.store = ""
                        self.presentationMode.wrappedValue.dismiss()
                    }
                    Button("新增"){
                        self.sheetState.calander = self.rkCalender.selectedDate
                        self.sheetState.IsOpended = false
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
            )
                .navigationBarTitle(Text(self.sheetState.store))
        }
    }
}
