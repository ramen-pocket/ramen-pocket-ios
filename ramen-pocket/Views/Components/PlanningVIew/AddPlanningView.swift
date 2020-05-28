//
//  NewPlanningView.swift
//  ramen-pocket
//
//  Created by Aaron Xue on 2020/5/26.
//  Copyright © 2020 姚韋辰. All rights reserved.
//

import SwiftUI

extension UIApplication {
    func endEditing(_ force: Bool) {
        self.windows
            .filter{$0.isKeyWindow}
            .first?
            .endEditing(force)
    }
}

struct ResignKeyboardOnDragGesture: ViewModifier {
    var gesture = DragGesture().onChanged{_ in
        UIApplication.shared.endEditing(true)
    }
    func body(content: Content) -> some View {
        content.gesture(gesture)
    }
}

extension View {
    func resignKeyboardOnDragGesture() -> some View {
        modifier(ResignKeyboardOnDragGesture())
    }
}

enum ActiveSheet {
    case storeSheet, calenderSheet, none
}

class SheetState: ObservableObject {
    @Published var activeSheet: ActiveSheet = .storeSheet
    @Published var store: String = ""
    @Published var calander: Date = Date()
    @Published var IsDimissed: Bool = false
}

//Steppter Control
struct AddPlanningView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject private var sheetState: SheetState = SheetState()
    
    var body: some View {
        NavigationView {
            if(self.sheetState.activeSheet == ActiveSheet.storeSheet) {
                SelectRamenStore(sheetState: sheetState)
                    .resignKeyboardOnDragGesture()
                    .navigationBarItems(trailing:
                        HStack{
                            Button("取消") {
                                self.presentationMode.wrappedValue.dismiss()
                            }
                        }
                )
            }
            else if(self.sheetState.activeSheet == ActiveSheet.calenderSheet) {
                SelectDateView(sheetState: sheetState)
                    .navigationBarItems(trailing:
                        HStack {
                            Button("上一頁") {
                                self.sheetState.activeSheet = ActiveSheet.storeSheet
                            }
                            Button("新增") {
                                self.presentationMode.wrappedValue.dismiss()
                            }
                    })
                    .resignKeyboardOnDragGesture()
            }
        }
    }
    
    struct NewPlanningView_Previews: PreviewProvider {
        
        static var previews: some View {
            AddPlanningView()
        }
    }
}
