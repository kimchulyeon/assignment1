////
////  Search.swift
////  Mail_Plug_Assignment
////
////  Created by chulyeon kim on 10/28/23.
////
//

import Foundation

enum TableType {
    case history
    case searchType
    case board
}

enum SearchType: String, CaseIterable {
    case all
    case title
    case contents
    case writer

    var korType: String {
        switch self {
        case .all:
            return "전체"
        case .title:
            return "제목"
        case .contents:
            return "내용"
        case .writer:
            return "작성자"
        }
    }

    static func fromKorType(_ korType: String) -> SearchType? {
        for type in Self.allCases {
            if type.korType == korType {
                return type
            }
        }
        return nil
    }
}
