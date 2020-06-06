//
//  Ramen.swift
//  ramen-pocket
//
//  Created by 姚韋辰 on 2020/5/15.
//  Copyright © 2020 姚韋辰. All rights reserved.
//

import Foundation

struct StoreResponse: Codable {
    let stores: [Store]
}

// MARK: - Store
struct Store: Codable, Identifiable {
    let id: Int
    let name: String
    let isDeleted, isCollected: Bool
    let location: Location
    let rate: Double
    let featuredImage: String
    let images: [String]
    let businessHours: [BusinessHour]
    let courses: [Course]
}

// MARK: - BusinessHour
struct BusinessHour: Codable {
    let off: Bool
    let begin: Double
    let end: Int
}

// MARK: - Course
struct Course: Codable {
    let name: String
    let price: Int
    let isRamen: Bool
}

// MARK: - Location
struct Location: Codable {
    let address: String
    let lat, lng: Double
}
