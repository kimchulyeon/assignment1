//
//  Post.swift
//  Mail_Plug_Assignment
//
//  Created by chulyeon kim on 10/23/23.
//

import Foundation

struct Posts: Codable {
    let value: [Post]
    let count: Int
    let offset: Int
    let limit: Int
    let total: Int
}

struct Post: Codable {
    let content: String
    let createdDateTime: String
    let viewCount: Int
    let postType: String
    let isNewPost: Bool
    let hasInlineImage: Bool
    let commentsCount: Int
    let attachmentsCount: Int
    let isAnonymous: Bool
    let isOwner: Bool
    let hasReply: Bool
}
