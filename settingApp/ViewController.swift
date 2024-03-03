//
//  ViewController.swift
//  settingApp
//
//  Created by Rustem on 03.03.2024.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(SettingTableViewCell.self, forCellReuseIdentifier: SettingTableViewCell.identifier)
        table.register(SwitchTableViewCell.self, forCellReuseIdentifier: SwitchTableViewCell.identifier)
        table.register(ProfileTableViewCell.self, forCellReuseIdentifier: ProfileTableViewCell.identifier)
        return table
    }()

    var models = [Section]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableView.automaticDimension
        configure()
        title = "Настройки"
        navigationController?.navigationBar.prefersLargeTitles = true
        setupHierarchy()
        setupLayout()
        tableView.dataSource = self
        tableView.delegate = self
    }

    private func configure() {
        models.insert(Section(title: "", option: [.profileCell(model: ProfileOption(imageName: "profile", name: "John Doe", subName: "Apple ID, iCloud+, контент и покупки", handler: { print("Profile tapped")}))]), at: 0)

        models.append(Section(title: "", option: [
            .switchCell(model: SwitchSettingOption(title: "Авиарежим", icon: UIImage(systemName: "airplane"), iconBackground: .systemOrange, handler: { }, isOn: false)),
            .staticCell(model: SettingOption(title: "Wi-Fi", icon: UIImage(systemName: "wifi"), iconBackgroundColor: .systemBlue, handler: { print("Wi-fi tapped")})),
            .staticCell(model: SettingOption(title: "Bluetooth", icon: UIImage(named: "bluetooth"), iconBackgroundColor: .systemBlue, handler: { print("Bluetooth tapped")})),
            .staticCell(model: SettingOption(title: "Сотовая связь", icon: UIImage(systemName: "antenna.radiowaves.left.and.right"), iconBackgroundColor: .systemGreen, handler: { print("Cellular tapped")})),
            .staticCell(model: SettingOption(title: "Режим модема", icon: UIImage(systemName: "personalhotspot"), iconBackgroundColor: .systemGreen, handler: { print("Cellular tapped")})),
            .switchCell(model: SwitchSettingOption(title: "VPN", icon: UIImage(systemName: "network.badge.shield.half.filled"), iconBackground: .systemBlue, handler: { print("VPN tapped")}, isOn: false)),
        ]))

        models.append(Section(title: "", option: [
            .staticCell(model: SettingOption(title: "Уведомления", icon: UIImage(systemName: "bell.badge.fill"), iconBackgroundColor: .systemRed, handler: {
                print("Notification tapped")})),
            .staticCell(model: SettingOption(title: "Звуки, тактильные сигналы", icon: UIImage(systemName: "speaker.wave.3.fill"), iconBackgroundColor: .systemRed, handler: {
                print("Sounds tapped")})),
            .staticCell(model: SettingOption(title: "Фокусирование", icon: UIImage(systemName: "powersleep"), iconBackgroundColor: .systemIndigo, handler: {
                print("focus tapped")})),
            .staticCell(model: SettingOption(title: "Экранное время", icon: UIImage(systemName: "hourglass"), iconBackgroundColor: .systemIndigo, handler: {
                print("screen Time tapped")})),
        ]))

        models.append(Section(title: "", option:[
            .staticCell(model: SettingOption(title: "Основные", icon: UIImage(systemName: "gear"), iconBackgroundColor: .systemGray2) { }),
            .staticCell(model: SettingOption(title: "Пункт управления", icon: UIImage(systemName: "switch.2"), iconBackgroundColor: .systemGray2) { }),
            .staticCell(model: SettingOption(title: "Экран и яркость", icon: UIImage(systemName: "sun.max"), iconBackgroundColor: .systemBlue) { }),
            .staticCell(model: SettingOption(title: "Экран \"Домой\" и библиотека приложений", icon: UIImage(systemName: "square.grid.4x3.fill"), iconBackgroundColor: .systemPurple) { }),
            .staticCell(model: SettingOption(title: "Универсальный доступ", icon: UIImage(systemName: "accessibility"), iconBackgroundColor: .systemBlue) { }),
            .staticCell(model: SettingOption(title: "Обои", icon: UIImage(systemName: "atom"), iconBackgroundColor: .systemCyan) { }),
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

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 && indexPath.row == 0 {
            return 80
        } else {
            return 44
        }
    }
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
            case .switchCell(let model):
                guard let cell = tableView.dequeueReusableCell(withIdentifier: SwitchTableViewCell.identifier, for: indexPath) as? SwitchTableViewCell else {
                    return UITableViewCell()
                }
                cell.configure(with: model)
                return cell
            case .profileCell(let model):
                guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileTableViewCell.identifier, for: indexPath) as? ProfileTableViewCell else {
                    return UITableViewCell()
                }
                cell.profileImageView.image = UIImage(named: model.imageName)
                cell.nameLabel.text = model.name
                cell.subNameLabel.text = model.subName
                return cell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let type = models[indexPath.section].option[indexPath.row]
        switch type.self {
            case .staticCell(let model):
                model.handler()
            case .switchCell(let model):
                model.handler()
            case .profileCell(let model):
                model.handler()
        }
    }
}
