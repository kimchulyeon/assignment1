//
//  BoardTableViewCell.swift
//  Mail_Plug_Assignment
//
//  Created by chulyeon kim on 10/23/23.
//

import UIKit

class BoardTableViewCell: UITableViewCell {
    // MARK: - properties
    static let identifier = "BoardTableViewCell"

    private let containerView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .yellow
        return v
    }()
    private let titleHStackView: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .horizontal
        sv.spacing = 4
        return sv
    }()
    private var postTypeBadgeView: PostBadgeView?
    private let titleLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont(name: "SpoqaHanSansNeo-Medium", size: 16)
        lb.numberOfLines = 1
        return lb
    }()
    private let attachmentImage: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "attachment")
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    private var newBadgeView: NewBadgeView?

    private let infoHStackView: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .horizontal
        sv.spacing = 4
        return sv
    }()
    private let dotView: UILabel = {
        let lb = UILabel()
        lb.text = "•"
        lb.font = UIFont(name: "SpoqaHanSansNeo-Light", size: 12)
        lb.textColor = UIColor(red: 158 / 255, green: 158 / 255, blue: 158 / 255, alpha: 1)
        return lb
    }()

    // MARK: - lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - func
    private func setView() {
        addSubview(containerView)
        containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 14).isActive = true
        containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -14).isActive = true
        containerView.topAnchor.constraint(equalTo: topAnchor, constant: 11).isActive = true
        containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -11).isActive = true
        
        containerView.addSubview(titleHStackView)
        titleHStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        titleHStackView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        titleHStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        
        containerView.addSubview(infoHStackView)
        infoHStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        infoHStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        infoHStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        infoHStackView.topAnchor.constraint(equalTo: titleHStackView.bottomAnchor).isActive = true
    }
    
    func configure(post: Post?) {
        if let type = post?.postType {
            postTypeBadgeView = PostBadgeView(type: type)
        }

        if let badgeView = postTypeBadgeView {
            titleHStackView.addArrangedSubview(badgeView)
        }

        titleLabel.text = post?.title
        titleHStackView.addArrangedSubview(titleLabel)

        if let attachmentCount = post?.attachmentsCount,
            attachmentCount > 0 {
            titleHStackView.addArrangedSubview(attachmentImage)
        }
        
        guard let isNew = post?.isNewPost,
              isNew == true else { return }
  
        newBadgeView = NewBadgeView()
        if let newBadgeView = newBadgeView {
            titleHStackView.addArrangedSubview(newBadgeView)
        }
    }
}
