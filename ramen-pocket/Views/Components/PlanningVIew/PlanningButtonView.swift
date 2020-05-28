//
//  PlanningButtonView.swift
//  ramen-pocket
//
//  Created by Aaron Xue on 2020/5/28.
//  Copyright © 2020 姚韋辰. All rights reserved.
//

import SwiftUI

class SheetState: ObservableObject {
    @Published var store: String = ""
    @Published var calander: Date = Date()
    @Published var IsOpended: Bool = false
    @Published var IsCalenderOpened: Bool = false
}

struct PlanningButtonView: View {
    @ObservedObject var sheetState: SheetState = SheetState()
    @State var showingDetail = false
    
    var body: some View {
        HStack(alignment: .firstTextBaseline, spacing: 0) {
            Spacer()
            Button(action: {
                self.sheetState.IsOpended.toggle()
            }, label: {
                Text("+")
                    .font(.system(.largeTitle))
                    .frame(width: 57, height: 50)
                    .foregroundColor(Color.white)
                    .padding(.bottom, 7)
            })
                .background(Color.red)
                .cornerRadius(38.5)
                .padding()
                .shadow(color: Color.black.opacity(0.3),
                        radius: 3,
                        x: 3,
                        y: 3)
                .sheet(isPresented: $sheetState.IsOpended)
                {
                    AddPlanningView(sheetState: self.sheetState)
            }
        }
    }
}

struct PlanningButtonView_Previews: PreviewProvider {
    static var previews: some View {
        PlanningButtonView()
    }
}
