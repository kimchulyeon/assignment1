//
//  HomeViewController.swift
//  Mail_Plug_Assignment
//
//  Created by chulyeon kim on 10/23/23.
//

import UIKit

class HomeViewController: UIViewController {
    //MARK: - properties ==================
    private let viewModel: HomeViewModel?
    private let customNav = CustomNavView()

    private lazy var boardTableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.separatorStyle = .none
        tv.delegate = self
        tv.dataSource = self
        tv.register(BoardTableViewCell.self, forCellReuseIdentifier: BoardTableViewCell.identifier)
        return tv
    }()

    let dummy: [Post] = [
        Post(postId: nil, title: "타이틀타이틀타이틀타이틀타이틀타이틀타이틀타이틀타이틀타이틀", boardId: nil, boardDisplayName: nil, writer: nil, content: nil, createdDateTime: nil, viewCount: nil, postType: .notice, isNewPost: true, hasInlineImage: nil, commentsCount: nil, attachmentsCount: 20, isAnonymous: nil, isOwner: nil, hasReply: nil, formattedCreatedDateTime: nil),
        Post(postId: nil, title: "타이틀1", boardId: nil, boardDisplayName: nil, writer: nil, content: nil, createdDateTime: nil, viewCount: nil, postType: .notice, isNewPost: nil, hasInlineImage: nil, commentsCount: nil, attachmentsCount: 2, isAnonymous: nil, isOwner: nil, hasReply: nil, formattedCreatedDateTime: nil),
        Post(postId: nil, title: "타이틀2", boardId: nil, boardDisplayName: nil, writer: nil, content: nil, createdDateTime: nil, viewCount: nil, postType: .notice, isNewPost: nil, hasInlineImage: nil, commentsCount: nil, attachmentsCount: nil, isAnonymous: nil, isOwner: nil, hasReply: nil, formattedCreatedDateTime: nil),
        Post(postId: nil, title: "타이틀3", boardId: nil, boardDisplayName: nil, writer: nil, content: nil, createdDateTime: nil, viewCount: nil, postType: .notice, isNewPost: nil, hasInlineImage: nil, commentsCount: nil, attachmentsCount: nil, isAnonymous: nil, isOwner: nil, hasReply: nil, formattedCreatedDateTime: nil),
        Post(postId: nil, title: "타이틀4", boardId: nil, boardDisplayName: nil, writer: Writer(displayName: "김철연", emailAddress: nil), content: nil, createdDateTime: nil, viewCount: nil, postType: .notice, isNewPost: nil, hasInlineImage: nil, commentsCount: nil, attachmentsCount: 1, isAnonymous: nil, isOwner: nil, hasReply: nil, formattedCreatedDateTime: nil),
        Post(postId: nil, title: "타이틀5", boardId: nil, boardDisplayName: nil, writer: nil, content: nil, createdDateTime: nil, viewCount: nil, postType: .notice, isNewPost: true, hasInlineImage: nil, commentsCount: nil, attachmentsCount: nil, isAnonymous: nil, isOwner: nil, hasReply: nil, formattedCreatedDateTime: nil),

    ]

    //MARK: - lifecycle ==================
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setView()

        viewModel?.boardsDidSet = { [weak self] boards in
            guard let firstTitle = boards?[0].displayName else { return }
            DispatchQueue.main.async {
                self?.customNav.setTitle(title: firstTitle)
            }
        }

        viewModel?.postsDidSet = { [weak self] posts in
            DispatchQueue.main.async {
                self?.boardTableView.reloadData()
            }
        }
    }

    func setView() {
        navigationController?.isNavigationBarHidden = true

        view.addSubview(customNav)
        customNav.translatesAutoresizingMaskIntoConstraints = false
        customNav.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        customNav.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        customNav.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        customNav.heightAnchor.constraint(equalToConstant: 60).isActive = true

        view.addSubview(boardTableView)
        boardTableView.topAnchor.constraint(equalTo: customNav.bottomAnchor).isActive = true
        boardTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        boardTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        boardTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
}

//MARK: - UITableViewDelegate ==================
extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let postCount = viewModel?.posts?.count else { return }
        if indexPath.row == postCount - 1 {
            if let canLoadMore = viewModel?.canLoadMorePosts(), canLoadMore == true {
                let nextOffset = viewModel?.posts?.count ?? 0
                viewModel?.fetchBoardPosts(boardID: viewModel?.boardID ?? 0, offset: nextOffset)
            }
        }
    }
}

//MARK: - UITableViewDataSource ==================
extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.posts?.count ?? 0
//        return dummy.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BoardTableViewCell.identifier, for: indexPath) as? BoardTableViewCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        let post = viewModel?.posts?[indexPath.row]
//        let post = dummy[indexPath.row]
        cell.configure(post: post)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 74
    }
}
