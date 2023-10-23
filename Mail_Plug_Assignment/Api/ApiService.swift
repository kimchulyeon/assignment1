//
//  ApiService.swift
//  Mail_Plug_Assignment
//
//  Created by chulyeon kim on 10/23/23.
//

import Foundation

class ApiService {
    static let shared = ApiService()
    private init() { }

    let decoder = JSONDecoder()
    let session = URLSessionManager.shared.session

    /// 게시판 리스트 가져오기
    func getBoardList(completion: @escaping ((BoardListResponse?) -> Void)) {
        let urlRequest = URLRequest(router: ApiRouter.board)
        session?.dataTask(with: urlRequest, completionHandler: { [weak self] data, response, error in
            guard let weakSelf = self else { return }
            
            if let error = error {
                print("❌ Error while getting board list with \(error)")
                return completion(nil)
            }

            guard let response = response as? HTTPURLResponse,
                  (200..<300).contains(response.statusCode) else {
                print("❌ Error while getting board list with invalid response")
                return completion(nil)
            }
            
            guard let data = data else {
                print("❌ Error while getting board list with invalid data")
                return completion(nil)
            }
            
            do {
                let boardData = try weakSelf.decoder.decode(BoardListResponse.self, from: data)
                completion(boardData)
            } catch {
                print("❌Error while getting board list with \(error.localizedDescription)")
                completion(nil)
            }
        })
        .resume()
    }
}
