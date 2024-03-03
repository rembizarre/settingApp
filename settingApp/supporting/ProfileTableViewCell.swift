//
//  ProfileTableViewCell.swift
//  settingApp
//
//  Created by Rustem on 03.03.2024.
//

import UIKit
import SnapKit

class ProfileTableViewCell: UITableViewCell {

    private lazy var profileImageView: UIImageView = {
        let profileImageView = UIImageView()
        profileImageView.contentMode = .scaleAspectFit
        profileImageView.clipsToBounds = true
        profileImageView.layer.cornerRadius = 30
        return profileImageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        return label
    }()

    private lazy var subNameLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 13, weight: .light)
        return label
    }()

    private var stack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .leading
        stack.distribution = .fill
        stack.spacing = 1
        return stack
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupHierarchy()
        setupLayout()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupHierarchy() {
        contentView.addSubview(profileImageView)
        contentView.addSubview(stack)
        stack.addArrangedSubview(nameLabel)
        stack.addArrangedSubview(subNameLabel)
        accessoryType = .disclosureIndicator
    }

    private func setupLayout() {
        profileImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(25)
            make.centerY.equalTo(contentView)
            make.width.height.equalTo(60)
        }

        stack.snp.makeConstraints { make in
            make.centerY.equalTo(profileImageView.snp.centerY)
            make.left.equalTo(profileImageView.snp.right).offset(20)
            make.right.equalToSuperview().inset(10)
        }
    }
}
