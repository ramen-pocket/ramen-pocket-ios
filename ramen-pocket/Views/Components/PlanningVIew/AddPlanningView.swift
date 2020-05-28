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

//Steppter Control
struct AddPlanningView: View {
    var sheetState: SheetState = SheetState()
    
    var body: some View {
        NavigationView {
            SelectStoreView(sheetState: sheetState)
                .resignKeyboardOnDragGesture()
                .navigationBarItems(trailing:
                    HStack{
                        Button("取消") {
                            self.sheetState.IsOpended = false
                        }
                    }
            )
            .navigationBarTitle("選擇店家")
        }
    }
    
    struct NewPlanningView_Previews: PreviewProvider {
        
        static var previews: some View {
            AddPlanningView()
        }
    }
}
