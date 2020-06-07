//
//  Comment.swift
//  ramen-pocket
//
//  Created by 姚韋辰 on 2020/6/7.
//  Copyright © 2020 姚韋辰. All rights reserved.
//

import Foundation

// MARK: - CommentResponse
struct CommentResponse: Decodable {
    let comments: [Comment]
}

// MARK: - Comment
struct Comment: Decodable, Identifiable {
    let id = UUID()
    let user: User
    let records: [Record]
}

// MARK: - Record
struct Record: Decodable {
    let id: Int
    let isDeleted: Bool
    let content: String
    let courses: [String]
    let rate: Double
    let publishedAt: Date
}

// MARK: - User
struct User: Decodable {
    let name: String
    let avatar: String
    let points: Int
}
