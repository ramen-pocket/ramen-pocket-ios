//
//  LoadingState.swift
//  ramen-pocket
//
//  Created by 姚韋辰 on 2020/6/5.
//  Copyright © 2020 姚韋辰. All rights reserved.
//

import Combine

class LoadingState: ObservableObject {
    let objectWillChange = PassthroughSubject<LoadingState, Never>()

    var isLoading: Bool = false {
        didSet {
            if (oldValue != isLoading) {
                objectWillChange.send(self)
            }
        }
    }
}
