//
//  AddCommentView.swift
//  ramen-pocket
//
//  Created by 姚韋辰 on 2020/6/20.
//  Copyright © 2020 姚韋辰. All rights reserved.
//

import SwiftUI
import Combine

struct AddCommentView: View {
    
    @EnvironmentObject var appState: AppState
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State var comment: String = "Ex. 叉燒很嫩，但湯太閒"
    @State var textHeight: CGFloat = 150
    @State var rate: Float = 4
    @State private var cancellable: AnyCancellable?
    let storeId: Int
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("新增評論")
                .font(.system(size: 40))
            MultilineTextView(placeholder: "Ex.", text: $comment, minHeight: 200, calculatedHeight: $textHeight)
                .frame(height: 200.0)
            
            Text("評分")
                .font(.system(size: 32))
                .padding(.top)
            Text(String(format:"%.1lf", rate))
            Slider(value: $rate, in: 1...5, step: 1)
            Button(action: {
                self.postComment()
            }) {
                Text("送出")
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .font(.system(size: 18))
                    .foregroundColor(Color.init(hex: "#333333"))
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(Color.init(hex: "#333333"), lineWidth: 2)
                )
            }
            .padding(.vertical)
            Spacer()
        }
        .padding(32)
    }
    
    func postComment() {
        self.cancellable = APIService.shared.postStoreComment(storeId, postComment: PostComment(content: comment, rate: Int(rate)))
            .sink(receiveCompletion: { (completion) in
                APIService.shared.handleReceiveCompletion(completion)
                self.appState.hideLoadingIndicator()
            }) { _ in
                self.presentationMode.wrappedValue.dismiss()
        }
    }
}

struct AddCommentView_Previews: PreviewProvider {
    static var previews: some View {
        AddCommentView(storeId: 0)
    }
}

