//
//  RamenCommentsView.swift
//  ramen-pocket
//
//  Created by 姚韋辰 on 2020/6/7.
//  Copyright © 2020 姚韋辰. All rights reserved.
//

import SwiftUI

struct RamenCommentsView: View {
    
    var comments: [Comment] = []
    
    init(comments: [Comment]) {
        UITableView.appearance().separatorStyle = .singleLine
        self.comments = comments
    }
    
    var body: some View {
        List(comments) { comment in
            CommentItem(comment: comment)
        }
        .navigationBarTitle("留言評論")
    }
}

struct RamenCommentsView_Previews: PreviewProvider {
    static var previews: some View {
        RamenCommentsView(comments: [])
    }
}
