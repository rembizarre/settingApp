//
//  ProfileViewController.swift
//  settingApp
//
//  Created by Rustem on 04.03.2024.
//

import UIKit

class ProfileViewController: UIViewController {

    // MARK: - Outlets
    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(ProfileTableViewCell.self, forCellReuseIdentifier: ProfileTableViewCell.identifier)
        table.register(SettingTableViewCell.self, forCellReuseIdentifier: SettingTableViewCell.identifier)
        table.register(TableHeader.self, forHeaderFooterViewReuseIdentifier: TableHeader.identifier)
        table.sectionHeaderHeight = 17
        return table
    }()

    var models = [Section]()

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configure()
        setupHierarchy()
        setupLayout()
        tableView.dataSource = self
        tableView.delegate = self
    }

    // MARK: - Setup
    private func configureNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.titleTextAttributes = [.font: UIFont.systemFont(ofSize: 16, weight: .semibold)]
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationItem.largeTitleDisplayMode = .never
        title = "Apple ID"
    }

    private func configure() {
        models.append(Section(option: [
            .staticCell(model: SettingOption(title: "Личная безопасность", icon: UIImage(systemName: "person.text.rectangle.fill"), iconBackgroundColor: .systemGray, handler: {})),
            .staticCell(model: SettingOption(title: "Вход и безопасность", icon: UIImage(systemName: "exclamationmark.shield.fill"), iconBackgroundColor: .systemGray, handler: {})),
            .staticCell(model: SettingOption(title: "Оплата и доставка", icon: UIImage(systemName: "creditcard.fill"), iconBackgroundColor: .systemGray, handler: {})),
            .staticCell(model: SettingOption(title: "Подписки", icon: UIImage(systemName: "goforward.plus"), iconBackgroundColor: .systemGray, handler: {})),
        ]))

        models.append(Section(option: [
            .staticCell(model: SettingOption(title: "iCloud", icon: UIImage(named: "icloud"), iconBackgroundColor: .systemBackground, handler: {})),
            .staticCell(model: SettingOption(title: "Контент и покупки", icon: UIImage(named: "appstore"), iconBackgroundColor: .systemBackground, handler: {})),
            .staticCell(model: SettingOption(title: "Локатор", icon: UIImage(named: "findmy"), iconBackgroundColor: .systemBackground, handler: {})),
            .staticCell(model: SettingOption(title: "Семейный доступ", icon: UIImage(named: "family"), iconBackgroundColor: .systemBackground, handler: {})),
        ]))
    }

    private func setupHierarchy() {
        view.addSubview(tableView)
    }

    private func setupLayout() {
        tableView.snp.makeConstraints { make in
            make.top.right.bottom.left.equalTo(view)
        }
    }
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        models.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models[section].option.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.section].option[indexPath.row]
        switch model.self {
            case .staticCell(let model):
                guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.identifier, for: indexPath) as? SettingTableViewCell else {
                    return UITableViewCell()
                }
                cell.configure(with: model)
                return cell
            default:
                break
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let type = models[indexPath.section].option[indexPath.row]
        switch type.self {
            case .staticCell(let model):
                model.handler()
            default:
                break
        }
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard section == 0 else {
            return nil
        }
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: TableHeader.identifier) as? TableHeader
        print("header is tapped")
        return header
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 200 : 0
    }
}
