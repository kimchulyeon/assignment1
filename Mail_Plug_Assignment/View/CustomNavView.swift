//
//  CustomNavView.swift
//  Mail_Plug_Assignment
//
//  Created by chulyeon kim on 10/23/23.
//

import UIKit

class CustomNavView: UIView {
    //MARK: - properties ==================
    private let containerView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    private let burgerButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(named: "burger"), for: .normal)
        btn.contentMode = .scaleAspectFit
        return btn
    }()
    private let navTitle: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont(name: "SpoqaHanSansNeo-Medium", size: 22)
        return lb
    }()
    private let searchButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(named: "search"), for: .normal)
        return btn
    }()

    //MARK: - lifecycle ==================
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setView()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - func ==================
    private func setView() {
        addSubview(containerView)
        containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18).isActive = true
        containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -18).isActive = true
        containerView.topAnchor.constraint(equalTo: topAnchor, constant: 18).isActive = true
        containerView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true

        containerView.addSubview(burgerButton)
        burgerButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        burgerButton.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        burgerButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        burgerButton.widthAnchor.constraint(equalToConstant: 24).isActive = true

        containerView.addSubview(navTitle)
        navTitle.leadingAnchor.constraint(equalTo: burgerButton.trailingAnchor, constant: 16).isActive = true
        navTitle.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        navTitle.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true

        containerView.addSubview(searchButton)
        searchButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        searchButton.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        searchButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        searchButton.widthAnchor.constraint(equalToConstant: 24).isActive = true
    }
    
    func setTitle(title: String) {
        navTitle.text = title
    }
}
