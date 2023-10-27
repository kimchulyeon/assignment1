//
//  SearchTypeTableViewCell.swift
//  Mail_Plug_Assignment
//
//  Created by chulyeon kim on 10/27/23.
//

import UIKit

class SearchTypeTableViewCell: UITableViewCell {
    //MARK: - properties
    static let identifier = "SearchTypeCell"

    let isHistoryCell: Bool
    let type: SearchType

    private let containerView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.heightAnchor.constraint(equalToConstant: 24).isActive = true
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
    private let searchTypeLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont(name: "SpoqaHanSansNeo-Regular", size: 14)
        lb.textColor = UIColor(red: 117 / 255, green: 117 / 255, blue: 117 / 255, alpha: 1)
        return lb
    }()
    private let searchLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont(name: "SpoqaHanSansNeo-Regular", size: 16)
        lb.numberOfLines = 1
        return lb
    }()
    private let accessoryImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        iv.heightAnchor.constraint(equalToConstant: 18).isActive = true
        iv.widthAnchor.constraint(equalToConstant: 18).isActive = true
        return iv
    }()

    //MARK: - lifecycle
    init(type: SearchType, isHistory: Bool) {
        self.type = type
        self.isHistoryCell = isHistory
        super.init(style: .default, reuseIdentifier: "SearchTypeCell")
        
        setView()
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
            
            containerView.addSubview(accessoryImageView)
            accessoryImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
            accessoryImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
            accessoryImageView.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        } else {
            containerView.addSubview(searchTypeLabel)
            searchTypeLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
            searchTypeLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
            
            containerView.addSubview(searchLabel)
            searchLabel.leadingAnchor.constraint(equalTo: searchTypeLabel.trailingAnchor, constant: 2).isActive = true
            searchLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
            
            containerView.addSubview(accessoryImageView)
            accessoryImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
            accessoryImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
            accessoryImageView.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        }
    }
}
