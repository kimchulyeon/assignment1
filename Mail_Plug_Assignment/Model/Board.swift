//
//  Board.swift
//  Mail_Plug_Assignment
//
//  Created by chulyeon kim on 10/23/23.
//

import Foundation

struct BoardListResponse: Codable {
    let value: [Board]
    let count: Int
    let offset: Int
    let limit: Int
    let total: Int
}

struct Board: Codable {
    let boardId: Int
    let displayName: String
}
