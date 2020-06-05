//
//  LoginView.swift
//  ramen-pocket
//
//  Created by 姚韋辰 on 2020/6/1.
//  Copyright © 2020 姚韋辰. All rights reserved.
//

import SwiftUI
import GoogleSignIn
import Combine

struct LoginView: View {
    
    @State private var cancellable: AnyCancellable?
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Hello")
                .font(.system(size: 48))
                .foregroundColor(Color.init(hex: "#333333"))
                .bold()
            Text("歡迎加入拉麵口袋，讓我們一起尋找屬於自己的拉麵吧！")
                .frame(width: 250)
                .padding(.bottom)
                .foregroundColor(Color.init(hex: "#666666"))
                
            Button(action: handleLogin, label: {
                HStack {
                    Image("ic_google")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                    Text("Google")
                        .font(.system(size: 20))
                }
            })
                .padding()
                .background(Color.white)
                .cornerRadius(8.0)
                .shadow(radius: 4.0)
                .buttonStyle(PlainButtonStyle())
            
        }
        .padding(32)
        .frame(minWidth: 0, maxWidth: .infinity, alignment: .topLeading)
        .onAppear {
            GIDSignIn.sharedInstance()?.presentingViewController = UIApplication.shared.windows.last?.rootViewController
            GIDSignIn.sharedInstance()?.restorePreviousSignIn()
        }
    }
    
    private func handleLogin() {
        GIDSignIn.sharedInstance()?.signIn()
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
