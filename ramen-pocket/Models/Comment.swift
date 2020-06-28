//
//  Comment.swift
//  ramen-pocket
//
//  Created by 姚韋辰 on 2020/6/7.
//  Copyright © 2020 姚韋辰. All rights reserved.
//

import Foundation

// MARK: - CommentResponse
struct CommentResponse: Codable {
    let comments: [Comment]
}

// MARK: - Comment
struct Comment: Codable, Identifiable {
    let id = UUID()
    let user: User
    let records: [Record]
}

// MARK: - Record
struct Record: Codable {
    let id: Int
    let content: String
    let courses: [String]
    let rate: Double
    let publishedAt: Date
}

// MARK: - User
struct User: Codable {
    let name: String
    let avatar: String
    let points: Int
}
