//
//  PlanningView.swift
//  ramen-pocket
//
//  Created by 陳威任 on 2020/5/24.
//  Copyright © 2020 姚韋辰. All rights reserved.
//

import SwiftUI

class PlanningState: ObservableObject {
    @Published var plans: [Plan] = [
        Plan(name: "鳥人拉麵 中山店", image: "Ramen1", bookDate: "2020/05/02", isExpired: false),
        Plan(name: "麵屋壹慶", image: "Ramen3", bookDate: "2020/05/02",isExpired: false),
        Plan(name: "五之神製作所 台灣", image: "Ramen2", bookDate: "2020/05/02",isExpired: false),
        Plan(name: "Okaeri お帰り 你回來啦拉麵", image: "Ramen4", bookDate: "2020/05/02",isExpired: false),
        Plan(name: "鷹流拉麵 台灣本店", image: "Ramen6", bookDate: "2020/05/02",isExpired: false),
        Plan(name: "雞二拉麵", image: "Ramen5", bookDate: "2020/05/02",isExpired: false),
        Plan(name: "麵屋牛一雞骨牛肉麵", image: "Ramen3", bookDate: "2020/05/02",isExpired: false)
    ]
}

struct PlanningView: View {
    @ObservedObject var planningState = PlanningState()
        
    var body: some View {
        NavigationView{
            ZStack{
                VStack(alignment: .leading, spacing: 0.0){
                    List(planningState.plans) { (plan)  in
                        PlanningItemView(plan: plan).padding(.top, 20)
                    }
                    .padding(.leading, -17)
                    .onAppear {
                        UITableView.appearance().separatorColor = .clear
                    }
                }
                
                VStack {
                    Spacer()
                    PlanningButtonView()
                }
            }
            .navigationBarTitle("計畫")
            
        }
        .padding()
    }
}

struct PlanningView_Previews: PreviewProvider {
    static var previews: some View {
        PlanningView()
    }
}
