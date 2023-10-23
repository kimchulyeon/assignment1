//
//  NewBadgeView.swift
//  Mail_Plug_Assignment
//
//  Created by chulyeon kim on 10/24/23.
//

import UIKit

class NewBadgeView: UIView {
    // MARK: - properties
    private let titleLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.text = "N"
        lb.textColor = .white
        lb.font = UIFont(name: "SpoqaHanSansNeo-Regular", size: 10)
        return lb
    }()
    
    // MARK: - lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - func
    private func setView() {
        layer.cornerRadius = 10
        backgroundColor = UIColor(red: 219/255, green: 71/255, blue: 13/255, alpha: 1)
        
        addSubview(titleLabel)
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4).isActive = true
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 1).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -1).isActive = true
    }
}
