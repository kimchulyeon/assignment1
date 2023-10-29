//
//  CustomSearchBarView.swift
//  Mail_Plug_Assignment
//
//  Created by chulyeon kim on 10/27/23.
//

import UIKit

protocol CustomSearchBarViewDelegate: NSObject {
    func tapCancelButton()
}

class CustomSearchBarView: UIView {
    //MARK: - properties
    weak var delegate: CustomSearchBarViewDelegate?

    private let containerHStackView: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .horizontal
        sv.spacing = 6
        sv.distribution = .fill
        sv.alignment = .center
        return sv
    }()
    private let textFieldContainerView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = UIColor.backgroundColor
        v.layer.cornerRadius = 4
        return v
    }()
    private lazy var textFieldHStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [textFieldLeftImage, searchTypeLabel, searchTextField])
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.spacing = 4
        sv.axis = .horizontal
        sv.distribution = .fillProportionally
        sv.alignment = .center
        return sv
    }()
    private let textFieldLeftImage: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = UIImage(systemName: "magnifyingglass")
        iv.tintColor = UIColor(red: 36 / 255, green: 30 / 255, blue: 23 / 255, alpha: 1)
        iv.contentMode = .scaleAspectFit
        iv.widthAnchor.constraint(equalToConstant: 20).isActive = true
        iv.heightAnchor.constraint(equalToConstant: 20).isActive = true
        return iv
    }()
    let searchTypeLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.textAlignment = .center
        lb.font = UIFont(name: "SpoqaHanSansNeo-Regular", size: 14)
        lb.textColor = UIColor.grayTextColor
        return lb
    }()
    lazy var searchTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    private lazy var cancelButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("취소", for: .normal)
        btn.titleLabel?.font = UIFont(name: "SpoqaHanSansNeo-Regular", size: 16)
        btn.setTitleColor(UIColor.grayTextColor, for: .normal)
        btn.addTarget(self, action: #selector(handleCancelButton), for: .touchUpInside)
        return btn
    }()

    //MARK: - lifecycle
    // Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)

        setView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    //MARK: - func
    private func setView() {
        let displayName = UserDefaultsManager.shared.getStringData(key: .boardDisplayName)
        searchTextField.placeholder = "\(displayName ?? "")에서 검색"

        addSubview(containerHStackView)
        containerHStackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        containerHStackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        containerHStackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        containerHStackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true

        containerHStackView.addArrangedSubview(textFieldContainerView)

        textFieldContainerView.addSubview(textFieldHStackView)
        textFieldHStackView.leadingAnchor.constraint(equalTo: textFieldContainerView.leadingAnchor, constant: 12).isActive = true
        textFieldHStackView.trailingAnchor.constraint(equalTo: textFieldContainerView.trailingAnchor, constant: -12).isActive = true
        textFieldHStackView.topAnchor.constraint(equalTo: textFieldContainerView.topAnchor, constant: 8).isActive = true
        textFieldHStackView.bottomAnchor.constraint(equalTo: textFieldContainerView.bottomAnchor, constant: -8).isActive = true


        containerHStackView.addArrangedSubview(cancelButton)
        cancelButton.heightAnchor.constraint(equalToConstant: 24).isActive = true
        cancelButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        cancelButton.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
    }

    @objc func doneButtonAction() {
        searchTextField.resignFirstResponder()
    }

    @objc func handleCancelButton() {
        delegate?.tapCancelButton()
    }
}

