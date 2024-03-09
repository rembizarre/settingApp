//
//  SettingTableViewCell.swift
//  settingApp
//
//  Created by Rustem on 03.03.2024.
//

import UIKit
import SnapKit

final class SettingWithInfoTableViewCell: UITableViewCell {
    static let identifier = "SettingWithInfoTableViewCell"

    // MARK: - UI
    private let iconContainer: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true
        return view
    }()

    private let iconImage: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .white
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()

    private let subLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray
        return label
    }()

    // MARK: - Initializer
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupHierarchy()
        setupLayout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup
    private func setupHierarchy() {
        contentView.addSubview(label)
        contentView.addSubview(subLabel)
        contentView.addSubview(iconContainer)
        iconContainer.addSubview(iconImage)
        contentView.clipsToBounds = true
        accessoryType = .disclosureIndicator
    }

    private func setupLayout() {
        iconContainer.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(6)
            make.left.equalToSuperview().offset(13)
            make.width.equalTo(iconContainer.snp.height)
            make.bottom.equalToSuperview().offset(-6)
        }


        iconImage.snp.makeConstraints { make in
            make.width.height.equalTo(iconContainer.snp.width).dividedBy(1.5)
            make.width.height.equalTo(20)
            make.center.equalTo(iconContainer.snp.center)
        }

        label.snp.makeConstraints { make in
            make.left.equalTo(iconContainer.snp.right).offset(15)
            make.top.bottom.equalToSuperview()
        }

        subLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-8)
            make.top.bottom.equalToSuperview()
        }
    }

    public func configure(with model: SettingWithInfoOption) {
        label.text = model.title
        iconImage.image = model.icon
        subLabel.text = model.label
        iconContainer.backgroundColor = model.iconBackgroundColor
    }

    // MARK: - Reuse
    override func prepareForReuse() {
        super.prepareForReuse()
        iconImage.image = nil
        label.text = nil
        iconContainer.backgroundColor = nil
    }
}
