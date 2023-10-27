//
//  MenuViewController.swift
//  Mail_Plug_Assignment
//
//  Created by chulyeon kim on 10/26/23.
//

import UIKit

class MenuViewController: UIViewController {
    //MARK: - properties
    private let viewModel: BoardViewModel?

    private lazy var dismissButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(systemName: "xmark"), for: .normal)
        btn.tintColor = UIColor(red: 36 / 255, green: 30 / 255, blue: 23 / 255, alpha: 1)
        btn.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
        return btn
    }()

    private let headerLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.text = "게시판"
        lb.font = UIFont(name: "SpoqaHanSansNeo-light", size: 14)
        lb.textColor = UIColor(red: 36 / 255, green: 30 / 255, blue: 23 / 255, alpha: 1)
        return lb
    }()

    private let dividerView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .lightGray
        return v
    }()

    private lazy var menuTableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.separatorStyle = .none
        tv.alwaysBounceVertical = false
        tv.delegate = self
        tv.dataSource = self
        tv.register(UITableViewCell.self, forCellReuseIdentifier: "menuCell")
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

        viewModel?.boardsDidSet = { [weak self] boards in
            DispatchQueue.main.async {
                self?.menuTableView.reloadData()
            }
        }

        setView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }

    //MARK: - func
    private func setView() {
        view.backgroundColor = .white

        view.addSubview(dismissButton)
        dismissButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 18).isActive = true
        dismissButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 18).isActive = true
        dismissButton.widthAnchor.constraint(equalToConstant: 24).isActive = true
        dismissButton.heightAnchor.constraint(equalToConstant: 24).isActive = true

        view.addSubview(headerLabel)
        headerLabel.topAnchor.constraint(equalTo: dismissButton.bottomAnchor, constant: 18).isActive = true
        headerLabel.leadingAnchor.constraint(equalTo: dismissButton.leadingAnchor).isActive = true

        view.addSubview(dividerView)
        dividerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        dividerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        dividerView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 18).isActive = true
        dividerView.heightAnchor.constraint(equalToConstant: 1).isActive = true


        view.addSubview(menuTableView)
        menuTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        menuTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        menuTableView.topAnchor.constraint(equalTo: dividerView.bottomAnchor, constant: 14).isActive = true
        menuTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }

    @objc func handleDismiss() {
        dismiss(animated: true)
    }
}


//MARK: - UITableViewDelegate
extension MenuViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedBoardID = viewModel?.boards?[indexPath.row].boardId
        viewModel?.changeBoardID(id: selectedBoardID)
        dismiss(animated: true)
    }
}

//MARK: - UITableViewDataSource 
extension MenuViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.boards?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menuCell", for: indexPath)
        cell.textLabel?.text = viewModel?.boards?[indexPath.row].displayName
        cell.selectionStyle = .none
        return cell
    }
}
