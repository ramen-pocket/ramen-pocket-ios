//
//  CommentItem.swift
//  ramen-pocket
//
//  Created by 姚韋辰 on 2020/5/18.
//  Copyright © 2020 姚韋辰. All rights reserved.
//

import SwiftUI

struct CommentItem: View {
    
    let comment: Comment
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                HStack {
                    ImageView(withurl: comment.user.avatar, width: 32, height: 32, cornerRadius: 16)
                    Text(comment.user.name)
                }
                HStack {
                    RatingView(rating: .constant(Int(comment.records.last!.rate)))
                    Text(convertDate(date: comment.records.last!.publishedAt))
                        .lineLimit(1)
                        .foregroundColor(Color.init(hex: "#333333"))
                }
                Text(comment.records.last!.content)
                    .foregroundColor(Color.init(hex: "#333333"))
                
            }
            .padding()
            Spacer()
            
        }
    }
    
    func convertDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY/MM/dd"
        return dateFormatter.string(from: date)
        
    }
}

struct CommentItem_Previews: PreviewProvider {
    static var previews: some View {
        CommentItem(comment: Comment(user: User(name: "Andy", avatar: "https://lh3.googleusercontent.com/a-/AOh14GgyqaWVV0q9efcQOGlEHTnaW49DCjKRpCQZADOX-N8=s96-c", points: 4), records: [Record(id: 1, content: "Test", courses: [], rate: 4.6, publishedAt: Date())]))
    }
}
