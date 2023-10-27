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
        return v
    }()
    private let titleHStackView: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .horizontal
        sv.spacing = 4
        sv.alignment = .center
        sv.distribution = .fill
        return sv
    }()
    private var postTypeBadgeView: PostBadgeView?

    private let titleLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont(name: "SpoqaHanSansNeo-Medium", size: 16)
        lb.numberOfLines = 1
        lb.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return lb
    }()
    private let attachmentImage: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = UIImage(named: "attachment")
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    private lazy var newBadgeImage: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = UIImage(named: "newPost")
        iv.contentMode = .scaleAspectFit
        return iv
    }()

    private let infoHStackView: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .horizontal
        sv.spacing = 4
        sv.alignment = .center
        sv.distribution = .fill
        return sv
    }()
    private let writerLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont(name: "SpoqaHanSansNeo-light", size: 12)
        lb.textColor = UIColor(red: 158 / 255, green: 158 / 255, blue: 158 / 255, alpha: 1)
        return lb
    }()
    private let dateLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont(name: "SpoqaHanSansNeo-light", size: 12)
        lb.textColor = UIColor(red: 158 / 255, green: 158 / 255, blue: 158 / 255, alpha: 1)
        return lb
    }()
    private let eyeIcon: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = UIImage(named: "eye")
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    private let viewCountLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont(name: "SpoqaHanSansNeo-light", size: 12)
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
        titleHStackView.trailingAnchor.constraint(lessThanOrEqualTo: containerView.trailingAnchor).isActive = true

        containerView.addSubview(infoHStackView)
        infoHStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        infoHStackView.trailingAnchor.constraint(lessThanOrEqualTo: containerView.trailingAnchor).isActive = true
        infoHStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        infoHStackView.topAnchor.constraint(equalTo: titleHStackView.bottomAnchor).isActive = true
    }

    func configure(post: Post?) {
        // titleHStackView
        titleHStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        infoHStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }

        if let type = post?.postType, (type == .notice || type == .reply) {
            postTypeBadgeView = PostBadgeView(type: type)
            guard let postTypeBadgeView = postTypeBadgeView else { return }
            postTypeBadgeView.translatesAutoresizingMaskIntoConstraints = false
            postTypeBadgeView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
            postTypeBadgeView.widthAnchor.constraint(equalToConstant: postTypeBadgeView.titleLabel.intrinsicContentSize.width + 16).isActive = true
            titleHStackView.addArrangedSubview(postTypeBadgeView)
        }

        titleLabel.text = post?.title
        titleHStackView.addArrangedSubview(titleLabel)

        if let attachmentCount = post?.attachmentsCount, attachmentCount > 0 {
            attachmentImage.widthAnchor.constraint(equalToConstant: 16).isActive = true
            attachmentImage.heightAnchor.constraint(equalToConstant: 16).isActive = true
            titleHStackView.addArrangedSubview(attachmentImage)
        }

        if let isNew = post?.isNewPost, isNew == true {
            newBadgeImage.widthAnchor.constraint(equalToConstant: 16).isActive = true
            newBadgeImage.heightAnchor.constraint(equalToConstant: 13).isActive = true
            titleHStackView.addArrangedSubview(newBadgeImage)
        }

        // infoHStackView
        if let name = post?.writer?.displayName {
            writerLabel.text = name
            infoHStackView.addArrangedSubview(writerLabel)
            infoHStackView.addArrangedSubview(makeDotView())
        }

        if let date = post?.formattedCreatedDateTime {
            dateLabel.text = date
            infoHStackView.addArrangedSubview(dateLabel)
            infoHStackView.addArrangedSubview(makeDotView())
        }

        eyeIcon.widthAnchor.constraint(equalToConstant: 16).isActive = true
        eyeIcon.heightAnchor.constraint(equalToConstant: 16).isActive = true
        infoHStackView.addArrangedSubview(eyeIcon)

        if let viewCount = (post?.viewCount) != nil ? post?.viewCount : 0 {
            viewCountLabel.text = viewCount.description
            infoHStackView.addArrangedSubview(viewCountLabel)
        }
    }

    func makeDotView() -> UILabel {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.text = "•"
        lb.font = UIFont(name: "SpoqaHanSansNeo-Light", size: 12)
        lb.textColor = UIColor(red: 158 / 255, green: 158 / 255, blue: 158 / 255, alpha: 1)
        return lb
    }
}
