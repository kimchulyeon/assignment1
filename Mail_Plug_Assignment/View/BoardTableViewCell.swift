//
//  BoardTableViewCell.swift
//  Mail_Plug_Assignment
//
//  Created by chulyeon kim on 10/23/23.
//

import UIKit

enum PostType {
    case notice
    case reply
    case normal
}

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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - func
    func configure(post: Post) {
        
    }
}
