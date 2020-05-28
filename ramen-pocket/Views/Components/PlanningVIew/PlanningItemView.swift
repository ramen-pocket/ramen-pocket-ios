//
//  PlanningItemView.swift
//  ramen-pocket
//
//  Created by Aaron Xue on 2020/5/28.
//  Copyright © 2020 姚韋辰. All rights reserved.
//

import SwiftUI

struct PlanningItemView: View {
    let plan: Plan
    
    var body: some View {
        HStack(alignment: .top, spacing: 0) {
            Image(plan.image)
                .resizable()
                .clipShape(Circle())
                .padding(.all)
                .scaledToFill()
                .frame(width: 76, height: 76)
                .clipped()
            
            VStack(alignment: .leading,spacing: 10) {
                Text(plan.name)
                    .font(.system(size: 30))
                    .bold()
                    .lineLimit(1)
                Text(plan.bookDate)
                    .font(.system(size: 22))
                    .foregroundColor(Color.gray)
                    .lineLimit(1)
            }
            .padding(.top, 1)
            Spacer()
        }
    }
}

struct PlanningItemView_Previews: PreviewProvider {
    static let plan: Plan = Plan(name: "五之神", image: "Ramen1", bookDate: "2020/05/04", isExpired: false
    )
    
    static var previews: some View {
        PlanningItemView(plan:plan)
    }
}
