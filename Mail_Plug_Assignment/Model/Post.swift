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
    let formattedCreatedDateTime: String?

    init(postId: Int?, title: String?, boardId: Int?, boardDisplayName: String?, writer: Writer?, content: String?, createdDateTime: String?, viewCount: Int?, postType: PostType?, isNewPost: Bool?, hasInlineImage: Bool?, commentsCount: Int?, attachmentsCount: Int?, isAnonymous: Bool?, isOwner: Bool?, hasReply: Bool?, formattedCreatedDateTime: String?) {
        self.postId = postId
        self.title = title
        self.boardId = boardId
        self.boardDisplayName = boardDisplayName
        self.writer = writer
        self.content = content
        self.createdDateTime = createdDateTime
        self.viewCount = viewCount
        self.postType = postType
        self.isNewPost = isNewPost
        self.hasInlineImage = hasInlineImage
        self.commentsCount = commentsCount
        self.attachmentsCount = attachmentsCount
        self.isAnonymous = isAnonymous
        self.isOwner = isOwner
        self.hasReply = hasReply
        self.formattedCreatedDateTime = formattedCreatedDateTime
    }

    enum CodingKeys: String, CodingKey {
        case postId, title, boardId, boardDisplayName, writer, content, createdDateTime, viewCount, postType, isNewPost, hasInlineImage, commentsCount, attachmentsCount, isAnonymous, isOwner, hasReply
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.postId = try container.decodeIfPresent(Int.self, forKey: .postId)
        self.title = try container.decodeIfPresent(String.self, forKey: .title)
        self.boardId = try container.decodeIfPresent(Int.self, forKey: .boardId)
        self.boardDisplayName = try container.decodeIfPresent(String.self, forKey: .boardDisplayName)
        self.writer = try container.decodeIfPresent(Writer.self, forKey: .writer)
        self.content = try container.decodeIfPresent(String.self, forKey: .content)
        self.createdDateTime = try container.decodeIfPresent(String.self, forKey: .createdDateTime)
        self.viewCount = try container.decodeIfPresent(Int.self, forKey: .viewCount)
        self.postType = try container.decodeIfPresent(PostType.self, forKey: .postType)
        self.isNewPost = try container.decodeIfPresent(Bool.self, forKey: .isNewPost)
        self.hasInlineImage = try container.decodeIfPresent(Bool.self, forKey: .hasInlineImage)
        self.commentsCount = try container.decodeIfPresent(Int.self, forKey: .commentsCount)
        self.attachmentsCount = try container.decodeIfPresent(Int.self, forKey: .attachmentsCount)
        self.isAnonymous = try container.decodeIfPresent(Bool.self, forKey: .isAnonymous)
        self.isOwner = try container.decodeIfPresent(Bool.self, forKey: .isOwner)
        self.hasReply = try container.decodeIfPresent(Bool.self, forKey: .hasReply)

        if let createdDateTime = self.createdDateTime {
            let dateFormatter = ISO8601DateFormatter()
            if let date = dateFormatter.date(from: createdDateTime) {
                let outputFormatter = DateFormatter()
                outputFormatter.dateFormat = "yy-MM-dd"
                self.formattedCreatedDateTime = outputFormatter.string(from: date)
            } else {
                self.formattedCreatedDateTime = nil
            }
        } else {
            self.formattedCreatedDateTime = nil
        }

    }
}

struct Writer: Codable {
    let displayName, emailAddress: String?
}
