//
//  SelectDateView.swift
//  ramen-pocket
//
//  Created by Aaron Xue on 2020/5/28.
//  Copyright © 2020 姚韋辰. All rights reserved.
//

import SwiftUI

struct SelectDateView: View {
    var sheetState: SheetState
    
    var body: some View {
        VStack {
            RKViewController(isPresented: .constant(false), rkManager: RKManager(calendar: Calendar.current, minimumDate: Date(), maximumDate: Date().addingTimeInterval(60*60*24*365*2), mode: 0))
        }
        .navigationBarTitle(Text("預定日期"))    
    }
}

struct SelectDateView_Previews: PreviewProvider {
    static var previews: some View {
        SelectDateView(sheetState: SheetState())
    }
}
