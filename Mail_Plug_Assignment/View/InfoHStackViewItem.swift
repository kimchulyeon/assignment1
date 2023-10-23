//
//  InfoHStackViewItem.swift
//  Mail_Plug_Assignment
//
//  Created by chulyeon kim on 10/24/23.
//

import UIKit

enum InfoItemType {
    case name
    case date
    case viewCount
}

class InfoHStackViewItem: UIView {
    // MARK: - properties
    private let containerView: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .horizontal
        sv.spacing = 2.5
        return sv
    }()
    private let viewCountImage: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        iv.image = UIImage(named: "eye")
        iv.isHidden = true
        return iv
    }()
    private let infoLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont(name: "SpoqaHanSansNeo-Light", size: 12)
        lb.textColor = UIColor(red: 158 / 255, green: 158 / 255, blue: 158 / 255, alpha: 1)
        return lb
    }()

    // MARK: - lifecycle
    init(text: String, type: InfoItemType) {
        super.init(frame: .zero)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - func
    private func setView(with type: InfoItemType, text: String) {
        switch type {
        case .name:
            infoLabel.text = text
            viewCountImage.isHidden = true
        case .date:
            #warning("FORMATTER") 
            infoLabel.text = text
            viewCountImage.isHidden = true
        case .viewCount:
            infoLabel.text = text
            viewCountImage.isHidden = false
        }

        containerView.addArrangedSubview(viewCountImage)
        containerView.addArrangedSubview(infoLabel)
    }
}
