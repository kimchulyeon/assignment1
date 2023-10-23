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
    private var boardsResponse: Boards? {
        didSet {
            boardsDidSet?(boardsResponse)
        }
    }
    var boardsDidSet: ((Boards?) -> Void)?
    
    
    private var postsResponse: Posts? {
        didSet {
            posts = postsResponse?.value
        }
    }
    var posts: [Post]? {
        didSet {
            postsDidSet?(posts)
        }
    }
    var postsDidSet: (([Post]?) -> Void)?
    

    /// 게시판 가져오기
    func fetchboards() {
        ApiService.shared.getBoards { [weak self] result in
            guard let weakSelf = self else { return }
            weakSelf.boardsResponse = result
        }
    }
    
    /// 게시판 게시글 가져오기
    func fetchBoardPosts(boardID: Int, offset: Int = 0, limit: Int = 30) {
        ApiService.shared.getPosts(boardID: boardID, offset: offset, limit: limit) { [weak self] result in
            guard let weakSelf = self else { return }
            weakSelf.postsResponse = result
        }
    }
}
