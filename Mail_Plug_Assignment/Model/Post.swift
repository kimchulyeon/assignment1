//
//  Post.swift
//  Mail_Plug_Assignment
//
//  Created by chulyeon kim on 10/23/23.
//

import Foundation

enum PostType: String, Codable {
    case notice = "notice"
    case reply = "reply"
    case normal = "normal"
}

struct Posts: Codable {
    let value: [Post]
    let count: Int
    let offset: Int
    let limit: Int
    let total: Int
}

struct Post: Codable {
    let postId: Int?
    let title: String?
    let boardId: Int?
    let boardDisplayName: String?
    let writer: Writer?
    let content: String?
    let createdDateTime: String?
    let viewCount: Int?
    let postType: PostType?
    let isNewPost: Bool?
    let hasInlineImage: Bool?
    let commentsCount: Int?
    let attachmentsCount: Int?
    let isAnonymous: Bool?
    let isOwner: Bool?
    let hasReply: Bool?
}

struct Writer: Codable {
    let displayName, emailAddress: String?
}
