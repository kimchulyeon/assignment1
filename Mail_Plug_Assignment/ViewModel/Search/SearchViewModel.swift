//
//  SearchViewModel.swift
//  Mail_Plug_Assignment
//
//  Created by chulyeon kim on 10/29/23.
//

import Foundation

class SearchViewModel {
    // MARK: - properties
    var boardID: Int? {
        guard let boardIdString = UserDefaultsManager.shared.getStringData(key: .boardID) else { return nil }
        return Int(boardIdString)
    }

    var tableType: TableType = .searchType {
        didSet {
            tableTypeChanged?(tableType)
        }
    }
    var tableTypeChanged: ((TableType) -> Void)?

    var currentSearchText: String? {
        didSet {
            searchTextUpdated?(currentSearchText)
        }
    }
    var searchTextUpdated: ((String?) -> Void)?

    var searchedPosts: Posts? {
        didSet {
            postsUpdated?(searchedPosts)
        }
    }
    var postsUpdated: ((Posts?) -> Void)?
    
    var historyDataChanged: (() -> Void)?
    var noDataViewChanged: ((String, String) -> Void)?

    // MARK: - method
    func fetchSearchedPosts() { }
}
