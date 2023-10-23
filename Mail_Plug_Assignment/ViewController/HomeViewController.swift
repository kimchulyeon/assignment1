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
        tv.delegate = self
        tv.dataSource = self
        tv.register(BoardTableViewCell.self, forCellReuseIdentifier: BoardTableViewCell.identifier)
        return tv
    }()

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
        
        viewModel?.boardsDidSet = { [weak self] response in
            guard let firstTitle = response?.value[0].displayName else { return }
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
    
}

//MARK: - UITableViewDataSource ==================
extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.posts?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BoardTableViewCell.identifier, for: indexPath) as? BoardTableViewCell else { return UITableViewCell() }
        let post = viewModel?.posts?[indexPath.row]
        cell.configure(post: post)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 74
    }
}
