//
//  SearchViewController.swift
//  Mail_Plug_Assignment
//
//  Created by chulyeon kim on 10/26/23.
//

import UIKit

class SearchViewController: UIViewController {
    //MARK: - properties ==================
    private let viewModel: BoardViewModel?
    
    //MARK: - lifecycle ==================
    init(viewModel: BoardViewModel?) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        let searchBar = UISearchBar()
        searchBar.placeholder = "\(viewModel?.displayName ?? "")에서 검색"
        navigationItem.titleView = searchBar
        navigationItem.hidesBackButton = true
        let cancel = UIBarButtonItem(title: "취소", style: .plain, target: nil, action: #selector(handleCancelButton))
            self.navigationItem.rightBarButtonItem = cancel
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    //MARK: - func ==================
    
    @objc func handleCancelButton() {
        
    }
}
