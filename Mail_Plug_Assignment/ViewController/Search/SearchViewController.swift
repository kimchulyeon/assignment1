//
//  SearchViewController.swift
//  Mail_Plug_Assignment
//
//  Created by chulyeon kim on 10/26/23.
//

import UIKit

class SearchViewController: UIViewController {
    //MARK: - properties
    private var tableType: TableType = .searchType {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.resultTableView.reloadData()
            }
        }
    }
    private var debounceTimer: Timer?
    private var currentSearchText: String? {
        didSet {
            if currentSearchText == "" {
                tableType = .searchType
            }
        }
    }

    private var searchedPosts: Posts? {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.resultTableView.reloadData()
            }
        }
    }

    private lazy var searchBarView = CustomSearchBarView()
    private var noDataView: NoDataView?
    private lazy var resultTableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.separatorInset = .zero
        tv.delegate = self
        tv.dataSource = self
        tv.backgroundColor = UIColor(red: 247 / 255, green: 247 / 255, blue: 247 / 255, alpha: 1)
        tv.register(BoardTableViewCell.self, forCellReuseIdentifier: BoardTableViewCell.identifier)
        tv.register(SearchTypeTableViewCell.self, forCellReuseIdentifier: SearchTypeTableViewCell.identifier)
        return tv
    }()

    //MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        searchBarView.searchTextField.delegate = self
        setView()

        if CoreDataManager.shared.fetchSearchHistory().isEmpty == true {
            setNoDataView(imageName: "noHistory", text: "게시글의 제목, 내용 또는 작성자에 포함된 단어 또는 문장을 검색해주세요.")
            resultTableView.removeFromSuperview()
        } else {
            showSearchTextWithTypeTableView()
            tableType = .history
        }
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
    }

    /// 검색 이력이 없을 때 NoDataView
    private func setNoDataView(imageName: String, text: String) {
        if noDataView != nil {
            noDataView?.removeFromSuperview()
            noDataView = nil
        }

        noDataView = NoDataView(imageName: imageName, text: text)
        guard let noDataView = noDataView else { return }

        view.addSubview(noDataView)
        noDataView.isHidden = false
        noDataView.translatesAutoresizingMaskIntoConstraints = false
        noDataView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        noDataView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        noDataView.topAnchor.constraint(equalTo: searchBarView.bottomAnchor, constant: 10).isActive = true
        noDataView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }

    /// 전체 제목 내용 작성자 테이블뷰
    private func showSearchTextWithTypeTableView() {
        view.addSubview(resultTableView)
        resultTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        resultTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        resultTableView.topAnchor.constraint(equalTo: searchBarView.bottomAnchor, constant: 10).isActive = true
        resultTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        resultTableView.reloadData()
    }

    /// TextField debounce
    @objc func debounceTextField() {
        if let text = debounceTimer?.userInfo as? String {
            DispatchQueue.main.async { [weak self] in
                self?.currentSearchText = text
                self?.searchBarView.searchTypeLabel.text = ""

                if let tableType = self?.tableType {
                    if (tableType == .board || tableType == .history) && text.isEmpty == false {
                        self?.tableType = .searchType
                        self?.noDataView?.isHidden = true
                        return
                    }
                }

                if text.isEmpty == false {
                    self?.showSearchTextWithTypeTableView()
                    self?.noDataView?.isHidden = true
                    return
                }

                if (text.isEmpty == true && CoreDataManager.shared.fetchSearchHistory().isEmpty == false) {
                    self?.tableType = .history
                    self?.noDataView?.isHidden = true
                    return
                }

                self?.setNoDataView(imageName: "noHistory", text: "게시글의 제목, 내용 또는 작성자에 포함된 단어 또는 문장을 검색해주세요.")
                self?.resultTableView.removeFromSuperview()
            }
        }
    }
}

//MARK: - UITableViewDelegate
extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let boardIdString = UserDefaultsManager.shared.getStringData(key: .boardID) else { return }
        let boardID = Int(boardIdString)
        
        if tableType == .searchType {
            self.searchedPosts = nil
            tableType = .board

            let searchTarget = SearchType.allCases[indexPath.row]
            searchBarView.searchTypeLabel.text = "\(searchTarget.korType) :" //
            

            if let currentSearchText = currentSearchText {
                CoreDataManager.shared.saveSearchHistory(searchText: currentSearchText, searchType: searchTarget.korType)
            }

            ApiService.shared.getSearchedPosts(boardID: boardID ?? 0, search: currentSearchText, searchTarget: searchTarget) { [weak self] searchedPosts in
                DispatchQueue.main.async {
                    if searchedPosts?.value.isEmpty == true {
                        self?.setNoDataView(imageName: "noResult", text: "검색 결과가 없습니다.\n 다른 검색어를 입력해 보세요.")
                    }
                    self?.searchedPosts = searchedPosts
                }
            }
        }

        if tableType == .history {
            let historySearchedText = CoreDataManager.shared.fetchSearchHistory()[indexPath.row].searchText
            guard let historySearchedTarget = SearchType.fromKorType(CoreDataManager.shared.fetchSearchHistory()[indexPath.row].searchType) else { return }
            
            ApiService.shared.getSearchedPosts(boardID: boardID ?? 0, search: historySearchedText, searchTarget: historySearchedTarget) { [weak self] searchedPosts in
                DispatchQueue.main.async {
                    if searchedPosts?.value.isEmpty == true {
                        self?.setNoDataView(imageName: "noResult", text: "검색 결과가 없습니다.\n 다른 검색어를 입력해 보세요.")
                    }
                    self?.tableType = .board
                    self?.searchedPosts = searchedPosts
                }
            }
        }
    }
}

//MARK: - UITableViewDataSource
extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableType == .searchType || tableType == .history {
            return 58
        } else {
            return 74
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableType == .searchType {
            return SearchType.allCases.count
        } else if tableType == .history {
            return CoreDataManager.shared.fetchSearchHistory().count
        } else {
            return searchedPosts?.value.count ?? 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableType == .searchType {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTypeTableViewCell.identifier, for: indexPath) as? SearchTypeTableViewCell else { return UITableViewCell() }
            cell.configure(type: SearchType.allCases[indexPath.row], isHistoryCell: false)
            cell.searchLabel.text = currentSearchText
            cell.selectionStyle = .none
            tableView.alwaysBounceVertical = false
            return cell
        } else if tableType == .history {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTypeTableViewCell.identifier, for: indexPath) as? SearchTypeTableViewCell else { return UITableViewCell() }
            cell.configure(type: SearchType.allCases[indexPath.row], isHistoryCell: true)
            cell.searchLabel.text = CoreDataManager.shared.fetchSearchHistory()[indexPath.row].searchText
            cell.searchTypeLabel.text = "\(CoreDataManager.shared.fetchSearchHistory()[indexPath.row].searchType) :"
            cell.index = indexPath.row
            cell.selectionStyle = .none
            cell.delegate = self
            tableView.alwaysBounceVertical = false
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: BoardTableViewCell.identifier, for: indexPath) as? BoardTableViewCell else { return UITableViewCell() }
            cell.configure(post: searchedPosts?.value[indexPath.row])
            cell.selectionStyle = .none
            tableView.alwaysBounceVertical = false
            return cell
        }
    }
}

//MARK: - CustomSearchBarViewDelegate
extension SearchViewController: CustomSearchBarViewDelegate {
    func tapCancelButton() {
        navigationController?.popViewController(animated: true)
    }
}

//MARK: - UITextFieldDelegate
extension SearchViewController: UITextFieldDelegate {
    // debounce (Rx, Timer, WorkItem)
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let inputText = currentText.replacingCharacters(in: stringRange, with: string)

        debounceTimer?.invalidate()
        debounceTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(debounceTextField), userInfo: inputText, repeats: false)
        return true
    }
}

// MARK: - SearchTypeTableViewCellDelegate
extension SearchViewController: SearchTypeTableViewCellDelegate {
    func deleteHistory() {
        resultTableView.reloadData()
    }
}
