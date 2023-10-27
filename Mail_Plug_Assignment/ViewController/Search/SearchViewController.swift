//
//  SearchViewController.swift
//  Mail_Plug_Assignment
//
//  Created by chulyeon kim on 10/26/23.
//

import UIKit

enum SearchType: String, CaseIterable {
    case all = "전체"
    case title = "제목"
    case content = "내용"
    case writer = "작성자"
}

class SearchViewController: UIViewController {
    //MARK: - properties
    private let viewModel: BoardViewModel?

    private lazy var searchBarView = CustomSearchBarView(viewModel: self.viewModel)
    private var noDataView: NoDataView?
    private lazy var resultTableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
//        tv.separatorStyle = .none
        tv.delegate = self
        tv.dataSource = self
        tv.backgroundColor = UIColor(red: 247 / 255, green: 247 / 255, blue: 247 / 255, alpha: 1)
        tv.register(BoardTableViewCell.self, forCellReuseIdentifier: BoardTableViewCell.identifier)
        tv.register(SearchTypeTableViewCell.self, forCellReuseIdentifier: SearchTypeTableViewCell.identifier)
        return tv
    }()

    //MARK: - lifecycle
    init(viewModel: BoardViewModel?) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setView()
    }

    //MARK: - func
    private func setView() {
        view.backgroundColor = .white

        view.addSubview(searchBarView)
        searchBarView.delegate = self
        searchBarView.translatesAutoresizingMaskIntoConstraints = false
        searchBarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        searchBarView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 18).isActive = true
        searchBarView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -18).isActive = true
        
        view.addSubview(resultTableView)
        resultTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        resultTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        resultTableView.topAnchor.constraint(equalTo: searchBarView.bottomAnchor).isActive = true
        resultTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }

    private func setNoDataView() {
        noDataView = NoDataView(imageName: "noHistory", text: "게시글의 제목, 내용 또는 작성자에 포함된 단어 또는 문장을 검색해주세요.")
        guard let noDataView = noDataView else { return }

        view.addSubview(noDataView)
        noDataView.translatesAutoresizingMaskIntoConstraints = false
        noDataView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        noDataView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        noDataView.topAnchor.constraint(equalTo: searchBarView.bottomAnchor).isActive = true
        noDataView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}

//MARK: - UITableViewDelegate
extension SearchViewController: UITableViewDelegate {

}

//MARK: - UITableViewDataSource
extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        SearchType.allCases.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTypeTableViewCell.identifier, for: indexPath) as? SearchTypeTableViewCell else { return UITableViewCell() }
        return cell
    }
}

//MARK: - CustomSearchBarViewDelegate
extension SearchViewController: CustomSearchBarViewDelegate {
    func tapCancelButton() {
        navigationController?.popViewController(animated: true)
    }
}
