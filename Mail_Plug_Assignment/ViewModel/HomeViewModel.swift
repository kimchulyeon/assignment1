//
//  BoardListViewModel.swift
//  Mail_Plug_Assignment
//
//  Created by chulyeon kim on 10/23/23.
//

import Foundation

class HomeViewModel: ViewModelType {
    /**
     boardID: 게시판 ID
     boards : 게시판
     posts : 게시판 내에 게시글
     */
    var boardID: Int? {
        didSet {
            guard let id = boardID else { return }
            print(id)
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

    private var isFetching = false
    private var totalPostsCount = 0


    /// 게시판 가져오기
    func fetchboards() {
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

    func canLoadMorePosts() -> Bool {
        return totalPostsCount > (posts?.count ?? 0)
    }
}
