//
//  NoDataView.swift
//  Mail_Plug_Assignment
//
//  Created by chulyeon kim on 10/26/23.
//

import UIKit

class NoDataView: UIView {
    //MARK: - properties ==================
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
        lb.textColor = UIColor(red: 117/255, green: 117/255, blue: 117/255, alpha: 1)
        lb.textAlignment = .center
        return lb
    }()
    
    //MARK: - lifecycle ==================
    init(imageName: String, text: String) {
        self.noDataImageView.image = UIImage(named: imageName)
        self.noDataLabel.text = text
        
        super.init(frame: .zero)
        
        setView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - func ==================
    private func setView() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1)
        
        addSubview(vStackView)
        vStackView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        vStackView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
}
