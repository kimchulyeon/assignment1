//
//  BoardListViewModel.swift
//  Mail_Plug_Assignment
//
//  Created by chulyeon kim on 10/23/23.
//

import Foundation

class BoardViewModel {
    //MARK: - properties
    var boardID: Int? {
        didSet {
            guard let id = boardID, let board = boards?.first(where: { $0.boardId == id }) else { return }
            UserDefaultsManager.shared.saveStringData(data: id.description, key: .boardID)
            totalPostsCount = 0
            isFetching = false
            posts = nil
            displayName = board.displayName
            fetchBoardPosts(boardID: id)
        }
    }
    var boards: [Board]? {
        didSet {
            boardsDidSet?(boards)
        }
    }
    var boardsDidSet: (([Board]?) -> Void)?

    var posts: [Post]? {
        didSet {
            postsDidSet?(posts)
        }
    }
    var postsDidSet: (([Post]?) -> Void)?

    var displayName: String? {
        didSet {
            UserDefaultsManager.shared.saveStringData(data: displayName, key: .boardDisplayName)
            displayNameDidSet?(displayName)
        }
    }
    var displayNameDidSet: ((String?) -> Void)?
    
    private var isFetching = false
    private var totalPostsCount = 0
    
    var searchValue: String? 




    //MARK: - method
    /// 게시판 가져오기
    func fetchBoards() {
        ApiService.shared.getBoards { [weak self] result in
            guard let weakSelf = self else { return }
            weakSelf.boards = result?.value
            weakSelf.boardID = result?.value[0].boardId
        }
    }

    /// 게시판 게시글 가져오기
    func fetchBoardPosts(boardID: Int, offset: Int = 0, limit: Int = 30) {
        guard isFetching == false else { return }
        isFetching = true

        ApiService.shared.getPosts(boardID: boardID, offset: offset, limit: limit) { [weak self] result in
            guard let weakSelf = self else { return }
            weakSelf.isFetching = false
            weakSelf.totalPostsCount = result?.total ?? 0

            if let newPosts = result?.value {
                if weakSelf.posts == nil {
                    weakSelf.posts = newPosts
                } else {
                    weakSelf.posts?.append(contentsOf: newPosts)
                }
            }
        }
    }

    /// 게시판 리스트를 더 불러올 수 있는지에 대한 불린값
    func canLoadMorePosts() -> Bool {
        return totalPostsCount > (posts?.count ?? 0)
    }

    /// 게시판 변경 (boardID값 변경)
    func changeBoardID(id: Int?) {
        if let id = id {
            boardID = id
        }
    }
}
