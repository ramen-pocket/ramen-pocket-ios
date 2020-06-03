//
//  UserAuth.swift
//  ramen-pocket
//
//  Created by 姚韋辰 on 2020/6/1.
//  Copyright © 2020 姚韋辰. All rights reserved.
//

import Foundation

class GlobalState: ObservableObject {
    @Published var isLogin = false
    @Published var isLoading = false
}
