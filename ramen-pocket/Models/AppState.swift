//
//  UserAuth.swift
//  ramen-pocket
//
//  Created by 姚韋辰 on 2020/6/1.
//  Copyright © 2020 姚韋辰. All rights reserved.
//

import Foundation
import Combine

class AppState: ObservableObject {
    
    let objectWillChange = PassthroughSubject<AppState, Never>()
    
    @Published var profile: Profile?

    var isLoading: Bool = false {
        didSet {
            if (oldValue != isLoading) {
                objectWillChange.send(self)
            }
        }
    }
    
    var isLogin: Bool = false {
        didSet {
            let preferences = UserDefaults.standard
            preferences.set(isLogin, forKey: "isLogin")
            objectWillChange.send(self)
        }
    }
}
