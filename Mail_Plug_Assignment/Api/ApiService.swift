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
    func getBoards(completion: @escaping ((Boards?) -> Void)) {
        print("GETBOARDS")
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
                let boardsData = try weakSelf.decoder.decode(Boards.self, from: data)
                completion(boardsData)
            } catch {
                print("❌Error while getting board list with \(error.localizedDescription)")
                completion(nil)
            }
        })
            .resume()
    }

    /// 게시판 게시글 가져오기
    func getPosts(boardID: Int, offset: Int = 0, limit: Int = 30, completion: @escaping ((Posts?) -> Void)) {
        print("GETPOSTS")
        let urlRequest = URLRequest(router: ApiRouter.post(boardID: boardID, offset: offset, limit: limit))
        session?.dataTask(with: urlRequest, completionHandler: { [weak self] data, response, error in
            guard let weakSelf = self else { return }

            if let error = error {
                print("❌ Error while getting posts with \(error)")
                return completion(nil)
            }

            guard let response = response as? HTTPURLResponse,
                (200..<300).contains(response.statusCode) else {
                print("❌ Error while getting posts with invalid response")
                return completion(nil)
            }

            guard let data = data else {
                print("❌ Error while getting posts with invalid data")
                return completion(nil)
            }

            do {
                let postsData = try weakSelf.decoder.decode(Posts.self, from: data)
                completion(postsData)
            } catch {
                print("❌Error while getting posts with \(error.localizedDescription)")
                completion(nil)
            }
        })
            .resume()
    }

    /// 검색된 게시글 가져오기
    func getSearchedPosts(boardID: Int, search: String? = "", searchTarget: SearchType, offset: Int = 0, limit: Int = 30, completion: @escaping ((Posts?) -> Void)) {
        let urlRequest = URLRequest(router: ApiRouter.search(boardID: boardID, searchValue: search, searchTarget: searchTarget.rawValue, offset: offset, limit: limit))
        session?.dataTask(with: urlRequest, completionHandler: { [weak self] data, response, error in
            guard let weakSelf = self else { return }

            if let error = error {
                print("❌ Error while getting searched posts with \(error)")
                return completion(nil)
            }

            guard let response = response as? HTTPURLResponse,
                (200..<300).contains(response.statusCode) else {
                print("❌ Error while getting searched posts with invalid response")
                return completion(nil)
            }

            guard let data = data else {
                print("❌ Error while getting searched posts with invalid data")
                return completion(nil)
            }

            do {
                let searchedData = try weakSelf.decoder.decode(Posts.self, from: data)
                completion(searchedData)
            } catch {
                print("❌Error while getting searched posts with \(error)")
                completion(nil)
            }
        })
            .resume()
    }
}
