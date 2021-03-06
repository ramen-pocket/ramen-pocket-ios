//
//  UserAuth.swift
//  ramen-pocket
//
//  Created by 姚韋辰 on 2020/6/1.
//  Copyright © 2020 姚韋辰. All rights reserved.
//

import Foundation
import Combine
import GoogleSignIn

class AppState: ObservableObject {
    
    let objectWillChange = PassthroughSubject<AppState, Never>()
    
    @Published var profile: Profile = Profile(userId: "", name: "", avatar: "", points: 0)

    var isLoading: Bool = false {
        didSet {
            if (oldValue != isLoading) {
                objectWillChange.send(self)
            }
        }
    }
    
    var idToken: String = "" {
        didSet {
            let preferences = UserDefaults.standard
            preferences.set(idToken, forKey: "idToken")
            if (idToken.isEmpty) {
                GIDSignIn.sharedInstance().signOut()
            }
            objectWillChange.send(self)
        }
    }
    
    func showLoadingIndicator() {
        isLoading = true
    }
    
    func hideLoadingIndicator() {
        isLoading = false
    }
    
}
