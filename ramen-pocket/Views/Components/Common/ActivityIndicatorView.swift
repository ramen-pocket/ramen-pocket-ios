//
//  ActivityIndicatorView.swift
//  ramen-pocket
//
//  Created by 姚韋辰 on 2020/6/3.
//  Copyright © 2020 姚韋辰. All rights reserved.
//

import SwiftUI

struct ActivityIndicatorView<Content>: View where Content: View {
    
    @EnvironmentObject var appState: AppState

    let content: () -> Content

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .center) {

                self.content()
                    .disabled(self.appState.isLoading)
                    .blur(radius: self.appState.isLoading ? 3 : 0)

                VStack {
                    Text("Loading...")
                    ActivityIndicator(isAnimating: .constant(true), style: .large)
                }
                .frame(width: geometry.size.width / 2,
                       height: geometry.size.height / 5)
                .background(Color.secondary.colorInvert())
                .foregroundColor(Color.primary)
                .cornerRadius(20)
                .opacity(self.appState.isLoading ? 1 : 0)

            }
        }
    }
}

struct ActivityIndicatorView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityIndicatorView() {
            Text("Test")
        }
    }
}
