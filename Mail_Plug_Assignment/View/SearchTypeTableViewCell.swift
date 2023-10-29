//
//  SearchTypeTableViewCell.swift
//  Mail_Plug_Assignment
//
//  Created by chulyeon kim on 10/27/23.
//

import UIKit

protocol SearchTypeTableViewCellDelegate: NSObject {
    func deleteHistory()
}

class SearchTypeTableViewCell: UITableViewCell {
    //MARK: - properties
    static let identifier = "SearchTypeCell"
    
    weak var delegate: SearchTypeTableViewCellDelegate?

    var index: Int?
    var isHistoryCell: Bool?
    var type: SearchType?

    private let containerView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    private let historyIcon: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = UIImage(named: "history")
        iv.contentMode = .scaleAspectFit
        iv.widthAnchor.constraint(equalToConstant: 24).isActive = true
//        iv.heightAnchor.constraint(equalToConstant: 24).isActive = true
        return iv
    }()
    let searchTypeLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont(name: "SpoqaHanSansNeo-Regular", size: 14)
        lb.textColor = UIColor(red: 117 / 255, green: 117 / 255, blue: 117 / 255, alpha: 1)
        return lb
    }()
    let searchLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont(name: "SpoqaHanSansNeo-Regular", size: 16)
        lb.numberOfLines = 1
        return lb
    }()
    private let accessoryButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.imageView?.contentMode = .scaleAspectFit
        btn.tintColor = UIColor(red: 66 / 255, green: 66 / 255, blue: 66 / 255, alpha: 1)
        btn.heightAnchor.constraint(equalToConstant: 18).isActive = true
        btn.widthAnchor.constraint(equalToConstant: 18).isActive = true
        return btn
    }()

    //MARK: - lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

//        setView()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - func
    private func setView() {
        contentView.backgroundColor = .white
        contentView.addSubview(containerView)
        containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 14).isActive = true
        containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -14).isActive = true
        containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12).isActive = true
        containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12).isActive = true

        if (isHistoryCell == true) {
            containerView.addSubview(historyIcon)
            historyIcon.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
            historyIcon.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true

            containerView.addSubview(searchTypeLabel)
            searchTypeLabel.leadingAnchor.constraint(equalTo: historyIcon.trailingAnchor, constant: 10).isActive = true
            searchTypeLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true

            containerView.addSubview(searchLabel)
            searchLabel.leadingAnchor.constraint(equalTo: searchTypeLabel.trailingAnchor, constant: 2).isActive = true
            searchLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true

            containerView.addSubview(accessoryButton)
            accessoryButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
            accessoryButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
            accessoryButton.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        } else {
            containerView.addSubview(searchTypeLabel)
            searchTypeLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
            searchTypeLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true

            containerView.addSubview(searchLabel)
            searchLabel.leadingAnchor.constraint(equalTo: searchTypeLabel.trailingAnchor, constant: 2).isActive = true
            searchLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true

            containerView.addSubview(accessoryButton)
            accessoryButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
            accessoryButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
            accessoryButton.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        }
    }

    func configure(type: SearchType, isHistoryCell: Bool) {
        self.type = type
        self.isHistoryCell = isHistoryCell

        for subview in contentView.subviews {
            subview.removeFromSuperview()
        }
        
        for subview in containerView.subviews {
            subview.removeFromSuperview()
        }

        contentView.backgroundColor = .white
        contentView.addSubview(containerView)
        containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 14).isActive = true
        containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -14).isActive = true
        containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12).isActive = true
        containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12).isActive = true

        if isHistoryCell {
            containerView.addSubview(historyIcon)
            historyIcon.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
            historyIcon.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true

            accessoryButton.setImage(UIImage(systemName: "xmark"), for: .normal)
            accessoryButton.addTarget(self, action: #selector(deleteHistory), for: .touchUpInside)
        } else {
            historyIcon.removeFromSuperview()
            accessoryButton.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        }

        containerView.addSubview(searchTypeLabel)
        searchTypeLabel.leadingAnchor.constraint(equalTo: isHistoryCell ? historyIcon.trailingAnchor : containerView.leadingAnchor, constant: 10).isActive = true
        searchTypeLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true

        containerView.addSubview(searchLabel)
        searchLabel.leadingAnchor.constraint(equalTo: searchTypeLabel.trailingAnchor, constant: 2).isActive = true
        searchLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true

        containerView.addSubview(accessoryButton)
        accessoryButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        accessoryButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        accessoryButton.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)

        switch type {
        case .all:
            searchTypeLabel.text = "전체 :"
        case .title:
            searchTypeLabel.text = "제목 :"
        case .contents:
            searchTypeLabel.text = "내용 :"
        case .writer:
            searchTypeLabel.text = "작성자 :"
        }
    }
    
    @objc func deleteHistory() {
        guard let index = index else { return }
        CoreDataManager.shared.deleteSearchHistory(at: index)
        delegate?.deleteHistory()
    }
}
