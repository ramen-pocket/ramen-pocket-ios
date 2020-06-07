//
//  ImageLoader.swift
//  ramen-pocket
//
//  Created by 姚韋辰 on 2020/6/6.
//  Copyright © 2020 姚韋辰. All rights reserved.
//

import SwiftUI
import Combine

class ImageLoader: ObservableObject {
    var didChange = PassthroughSubject<Data, Never>()
    
    var data = Data() {
        didSet {
            didChange.send(data)
        }
    }
    
    init(imageURL: String) {
        guard let url = URL(string: imageURL) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            DispatchQueue.main.async { self.data = data }
        }
        task.resume()
    }
}
