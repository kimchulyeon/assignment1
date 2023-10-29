//
//  ApiRouter.swift
//  Mail_Plug_Assignment
//
//  Created by chulyeon kim on 10/23/23.
//

import Foundation

enum ApiRouter {
    case board
    case post(boardID: Int, offset: Int, limit: Int = 30)
    case search(boardID: Int, searchValue: String?, searchTarget: SearchType.RawValue, offset: Int, limit: Int = 30)

    /// 도메인
    var baseURL: String {
        switch self {
        case .board, .post, .search:
            return Api.BASE_URL
        }
    }
    
    /// GET | POST | DELETE | PUT
    var method: String {
        switch self {
        case .board, .post, .search:
            return "GET"
        }
    }
    
    /// URL PATH
    var path: String {
        switch self {
        case .board:
            return "boards"
        case .post(boardID: let id, offset: _, limit: _):
            return "boards/\(id)/posts"
        case .search(boardID: let id, searchValue: _, searchTarget: _, offset: _, limit: _):
            return "boards/\(id)/posts"
        }
    }
    
    /// Query String
    var queryString: [String: Any]? {
        switch self {
        case .board:
            return nil
        case .post(boardID: _, offset: let offset, limit: let limit):
            return ["offset": offset, "limit": limit]
        case .search(boardID: _, searchValue: let searchValue, searchTarget: let searchTarget, offset: let offset, limit: let limit):
            return ["search": searchValue ?? "", "searchTarget": searchTarget, "offset": offset, "limit": limit]
        }
    }
    
    /// Body
    var body: Data? {
        switch self {
        case .board, .post, .search:
            return nil
        }
    }
    
    /// Header
    var header: [String: String]? {
        switch self {
        case .board, .post, .search:
            return ["Authorization": "Bearer \(Api.KEY)"]
        }
    }
}
