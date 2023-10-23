//
//  BoardListViewModel.swift
//  Mail_Plug_Assignment
//
//  Created by chulyeon kim on 10/23/23.
//

import Foundation

class BoardListViewModel: ViewModelType {
    var boardList: BoardListResponse? {
        didSet {
            boardListDidSet?(boardList)
        }
    }
    
    var boardListDidSet: ((BoardListResponse?) -> Void)?

    func fetchData() {
        ApiService.shared.getBoardList { [weak self] result in
            guard let weakSelf = self else { return }
            weakSelf.boardList = result
        }
    }
}
