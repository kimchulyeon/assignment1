//
//  NoDataView.swift
//  Mail_Plug_Assignment
//
//  Created by chulyeon kim on 10/26/23.
//

import UIKit

class NoDataView: UIView {
    //MARK: - properties
    private lazy var vStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [noDataImageView, noDataLabel])
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .vertical
        sv.spacing = 24
        sv.alignment = .center
        return sv
    }()
    
    private let noDataImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.heightAnchor.constraint(equalToConstant: 160).isActive = true
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    private let noDataLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont(name: "SpoqaHanSansNeo-Regular", size: 14)
        lb.textColor = UIColor.grayTextColor
        lb.textAlignment = .center
        lb.numberOfLines = 0
        return lb
    }()
    
    //MARK: - lifecycle
    init(imageName: String, text: String) {
        self.noDataImageView.image = UIImage(named: imageName)
        self.noDataLabel.text = text
        
        super.init(frame: .zero)
        
        setView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - func 
    private func setView() {
        backgroundColor = UIColor.backgroundColor
        
        addSubview(vStackView)
        vStackView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        vStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 69).isActive = true
        vStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -69).isActive = true
    }
}
