//
//  HeaderView.swift
//  settingApp
//
//  Created by Rustem on 04.03.2024.
//

import UIKit

final class TableHeader: UITableViewHeaderFooterView {
    static let identifier = "TableHeader"

    // MARK: - Outlets
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "profile")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 40
        imageView.layer.masksToBounds = true
        return imageView
    }()

    private let label: UILabel = {
        let label = UILabel()
        label.text = "John Doe"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 30, weight: .regular)
        return label
    }()

    private let subLabel: UILabel = {
        let label = UILabel()
        label.text = "john.doe@mail.com"
        label.font = UIFont.systemFont(ofSize: 15, weight: .light)
        return label
    }()

    // MARK: - Initializers
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupHierarchy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupHierarchy() {
        contentView.addSubview(imageView)
        contentView.addSubview(label)
        contentView.addSubview(subLabel)
        contentView.backgroundColor = .systemBackground
    }

    // MARK: - Setup
    private func setupLayout() {
        imageView.snp.makeConstraints { make in
            make.centerX.equalTo(contentView)
            make.top.equalTo(contentView).offset(15)
            make.width.height.equalTo(80)
        }

        label.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(10)
            make.centerX.equalTo(contentView)
        }

        subLabel.snp.makeConstraints { make in
            make.top.equalTo(label.snp.bottom).offset(5)
            make.centerX.equalTo(contentView)
        }
    }
}
