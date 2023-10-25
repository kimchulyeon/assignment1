//
//  PostBadgeView.swift
//  Mail_Plug_Assignment
//
//  Created by chulyeon kim on 10/23/23.
//

import UIKit

class PostBadgeView: UIView {
    // MARK: - properties
    var type: PostType

    let titleLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont(name: "SpoqaHanSansNeo-Regular", size: 12)
        lb.textColor = .white
        lb.textAlignment = .center
        return lb
    }()

    // MARK: - lifecycle
    init(type: PostType) {
        self.type = type
        super.init(frame: .zero)
        setView(with: type)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - func
    private func setView(with type: PostType) {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 10

        setLabel(type: type)

        addSubview(titleLabel)
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
        titleLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }

    private func setLabel(type: PostType) {
        switch type {
        case .notice:
            titleLabel.text = "공지"
            backgroundColor = UIColor(red: 255 / 255, green: 199 / 255, blue: 68 / 255, alpha: 1)
        case .reply:
            titleLabel.text = "Re"
            backgroundColor = UIColor(red: 71 / 255, green: 57 / 255, blue: 43 / 255, alpha: 1)
        default:
            break
        }
    }
}
