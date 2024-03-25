//
//  ViewController.swift
//  settingApp
//
//  Created by Rustem on 03.03.2024.
//

import UIKit
import SnapKit

final class ViewController: UIViewController {

    // MARK: - UI
    private let searchController = UISearchController()

    private lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .insetGrouped)
        table.register(SettingTableViewCell.self, forCellReuseIdentifier: SettingTableViewCell.identifier)
        table.register(SwitchTableViewCell.self, forCellReuseIdentifier: SwitchTableViewCell.identifier)
        table.register(ProfileTableViewCell.self, forCellReuseIdentifier: ProfileTableViewCell.identifier)
        table.register(SettingWithInfoTableViewCell.self, forCellReuseIdentifier: SettingWithInfoTableViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        table.backgroundColor = .systemGray6
        return table
    }()

    var models = [Section]()
    //to store unfiltered data
    var originalModels = [Section]()


    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        title = "Настройки"
        setupSearchController()
        setupHierarchy()
        setupLayout()
    }
    // MARK: - Setup
    private func configure() {
        models.insert(Section(option: [.profileCell(model: ProfileOption(imageName: "profile", name: "John Doe", subName: "Apple ID, iCloud+, контент и покупки", handler: {
            [weak self] in
            let profileVC = ProfileViewController()
            self?.navigationController?.pushViewController(profileVC, animated: true)
        }))]), at: 0)
        models.append(Section(option: [
            .switchCell(model: SwitchSettingOption(title: "Авиарежим", icon: UIImage(systemName: "airplane"), iconBackground: .systemOrange, handler: { print("Airplane mode is ON")}, isOn: false)),
            .staticCellWithInfo(model: SettingWithInfoOption(title: "Wi-Fi", icon: UIImage(systemName: "wifi"), iconBackgroundColor: .systemBlue, label: "Rem", handler: { print("Wi-fi tapped")})),
            .staticCellWithInfo(model: SettingWithInfoOption(title: "Bluetooth", icon: UIImage(named: "bluetooth"), iconBackgroundColor: .systemBlue, label: "Вкл.", handler: { print("Bluetooth tapped")})),
            .staticCell(model: SettingOption(title: "Сотовая связь", icon: UIImage(systemName: "antenna.radiowaves.left.and.right"), iconBackgroundColor: .systemGreen, handler: { print("Cellular tapped")})),
            .staticCell(model: SettingOption(title: "Режим модема", icon: UIImage(systemName: "personalhotspot"), iconBackgroundColor: .systemGreen, handler: { print("HotSpot tapped")})),
            .switchCell(model: SwitchSettingOption(title: "VPN", icon: UIImage(systemName: "network.badge.shield.half.filled"), iconBackground: .systemBlue, handler: { print("VPN is on")}, isOn: false)),
        ]))
        models.append(Section(option: [
            .staticCell(model: SettingOption(title: "Уведомления", icon: UIImage(systemName: "bell.badge.fill"), iconBackgroundColor: .systemRed, handler: {
                print("Notification tapped")})),
            .staticCell(model: SettingOption(title: "Звуки, тактильные сигналы", icon: UIImage(systemName: "speaker.wave.3.fill"), iconBackgroundColor: .systemRed, handler: {
                print("Sounds tapped")})),
            .staticCell(model: SettingOption(title: "Фокусирование", icon: UIImage(systemName: "powersleep"), iconBackgroundColor: .systemIndigo, handler: {
                print("focus tapped")})),
            .staticCell(model: SettingOption(title: "Экранное время", icon: UIImage(systemName: "hourglass"), iconBackgroundColor: .systemIndigo, handler: {
                print("screen Time tapped")})),
        ]))

        models.append(Section(option:[
            .staticCell(model: SettingOption(title: "Основные", icon: UIImage(systemName: "gear"), iconBackgroundColor: .systemGray) { print("general Time tapped")}),
            .staticCell(model: SettingOption(title: "Пункт управления", icon: UIImage(systemName: "switch.2"), iconBackgroundColor: .systemGray) {print("control center tapped") }),
            .staticCell(model: SettingOption(title: "Экран и яркость", icon: UIImage(systemName: "sun.max"), iconBackgroundColor: .systemBlue) { print("display tapped") }),
            .staticCell(model: SettingOption(title: "Экран \"Домой\" и библиотека приложений", icon: UIImage(systemName: "square.grid.4x3.fill"), iconBackgroundColor: .systemPurple) { print("AppGalery tapped")}),
            .staticCell(model: SettingOption(title: "Универсальный доступ", icon: UIImage(systemName: "accessibility"), iconBackgroundColor: .systemBlue) { print("Accessibility tapped") }),
            .staticCell(model: SettingOption(title: "Обои", icon: UIImage(systemName: "atom"), iconBackgroundColor: .systemCyan) { print("Wallpaper tapped")}),
        ]))
        originalModels = models
        tableView.reloadData()
    }

    private func setupHierarchy() {
        view.addSubview(tableView)
    }

    private func setupLayout() {
        tableView.snp.makeConstraints { make in
            make.top.right.bottom.left.equalTo(view)
        }
    }

    private func setupSearchController() {
        searchController.searchBar.placeholder = "Поиск"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = searchController
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).title = "Отменить"
        searchController.searchResultsUpdater = self
        definesPresentationContext = true
        searchController.searchBar.showsBookmarkButton = true
        searchController.searchBar.setImage(UIImage(systemName: "mic.fill"), for: .bookmark, state: .normal)
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate, UISearchResultsUpdating {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model = models[indexPath.section].option[indexPath.row]
        switch model {
            case .profileCell(_):
                return 70
            default:
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
                cell.configure(with: model)
                return cell
            case .staticCellWithInfo(let model):
                guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingWithInfoTableViewCell.identifier, for: indexPath) as? SettingWithInfoTableViewCell else {
                    return UITableViewCell()
                }
                cell.configure(with: model)
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
            case .staticCellWithInfo(model: let model):
                model.handler()
        }
    }
    // search functionality
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text, !searchText.isEmpty else {
            models = originalModels
            tableView.reloadData()
            return
        }

        // filter models based on search text
        models = originalModels.map { section in
            let filteredOptions = section.option.filter { option in
                switch option {
                    case .profileCell(let model):
                        return model.name.lowercased().contains(searchText.lowercased())
                    case .staticCell(let model):
                        return model.title.lowercased().contains(searchText.lowercased())
                    case .switchCell(let model):
                        return model.title.lowercased().contains(searchText.lowercased())
                    case .staticCellWithInfo(let model):
                        return model.title.lowercased().contains(searchText.lowercased())
                }
            }
            return Section(option: filteredOptions)
        }.filter { !$0.option.isEmpty }
        tableView.reloadData()
    }
}
