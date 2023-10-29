//
//  BoardViewController.swift
//  Mail_Plug_Assignment
//
//  Created by chulyeon kim on 10/23/23.
//

import UIKit

class BoardViewController: UIViewController {
    //MARK: - properties
    private let viewModel: BoardViewModel?
    private lazy var customNav: CustomNavView = {
        let v = CustomNavView(viewModel: self.viewModel)
        v.translatesAutoresizingMaskIntoConstraints = false
        v.delegate = self
        return v
    }()
    private var noDataView: NoDataView?

    private lazy var boardTableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.separatorStyle = .none
        tv.delegate = self
        tv.dataSource = self
        tv.register(BoardTableViewCell.self, forCellReuseIdentifier: BoardTableViewCell.identifier)
        return tv
    }()

    //MARK: - lifecycle
    init(viewModel: BoardViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setView()
        bindViewModel()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.isNavigationBarHidden = true
    }

    //MARK: - func
    private func setView() {
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

    private func bindViewModel() {
        viewModel?.postsDidSet = { [weak self] posts in
            DispatchQueue.main.async {
                self?.boardTableView.reloadData()
            }
        }
    }

    private func setNoDataView() {
        noDataView = NoDataView(imageName: "noPost", text: "등록된 게시글이 없습니다.")
        guard let noDataView = noDataView else { return }

        view.addSubview(noDataView)
        noDataView.translatesAutoresizingMaskIntoConstraints = false
        noDataView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        noDataView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        noDataView.topAnchor.constraint(equalTo: customNav.bottomAnchor).isActive = true
        noDataView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}

//MARK: - UITableViewDelegate
extension BoardViewController: UITableViewDelegate {
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

//MARK: - UITableViewDataSource
extension BoardViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewModel?.posts?.count == 0 {
            setNoDataView()
        } else {
            noDataView = nil
        }
        return viewModel?.posts?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BoardTableViewCell.identifier, for: indexPath) as? BoardTableViewCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        let post = viewModel?.posts?[indexPath.row]
        cell.configure(post: post)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 74
    }
}

//MARK: - CustomNavViewDelegate
extension BoardViewController: CustomNavViewDelegate {
    func tapBurgerButton() {
        let menuVC = MenuViewController(viewModel: self.viewModel)
        present(menuVC, animated: true)
    }

    func tapSearchButton() {
        let searchVC = SearchViewController()
        navigationController?.pushViewController(searchVC, animated: true)
    }
}

