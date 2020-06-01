//
//  LoginView.swift
//  ramen-pocket
//
//  Created by 姚韋辰 on 2020/6/1.
//  Copyright © 2020 姚韋辰. All rights reserved.
//

import SwiftUI
import GoogleSignIn

struct LoginView: View {
    
    init() {
        GIDSignIn.sharedInstance()?.presentingViewController = UIApplication.shared.windows.last?.rootViewController
        GIDSignIn.sharedInstance()?.restorePreviousSignIn()
    }
    
    var body: some View {
        Button("Login", action: handleLogin)
    }
    
    private func handleLogin() {
        let test = GIDSignIn.sharedInstance()?.signIn()
        print(test)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
