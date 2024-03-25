//
//  ViewController.swift
//  settingApp
//
//  Created by Rustem on 03.03.2024.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    // MARK: - UI
    private let searchController = UISearchController()
    private let dataManager = SettingsDataManager()
    private lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .insetGrouped)
        table.register(SettingTableViewCell.self, forCellReuseIdentifier: SettingTableViewCell.identifier)
        table.register(SwitchTableViewCell.self, forCellReuseIdentifier: SwitchTableViewCell.identifier)
        table.register(ProfileTableViewCell.self, forCellReuseIdentifier: ProfileTableViewCell.identifier)
        table.register(SettingWithInfoTableViewCell.self, forCellReuseIdentifier: SettingWithInfoTableViewCell.identifier)
        table.dataSource = self
        table.delegate = self
        table.backgroundColor = .systemGray6
        return table
    }()

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        title = "Настройки"
    }
    private func  configureUI() {
        setupSearchController()
        configure()
        setupHierarchy()
        setupLayout()
        tableView.reloadData()
    }
    //to unclipp tableview from Navbar when returning back to main ViewController
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.contentInset = UIEdgeInsets(top: 15, left: 0, bottom: 0, right: 0)
    }

    // MARK: - Setup
    private func configure() {
        dataManager.models.insert(Section(option: [.profileCell(model: ProfileOption(imageName: "profile", name: "John Doe", subName: "Apple ID, iCloud+, контент и покупки", handler: {
            [ weak self ] in
            guard let self = self else { return }
                   let profileModel = ProfileOption(imageName: "profile", name: "John Doe", subName: "Apple ID, iCloud+, контент и покупки", handler: {})
                   self.navigateToProfile(with: profileModel)
               }))
           ]), at: 0)
        dataManager.models.append(Section(option: [
            .switchCell(model: SwitchSettingOption(title: "Авиарежим", icon: "airplane", iconBackground: "systemOrange", handler: { print("Airplane mode is ON")}, isOn: false)),
            .staticCellWithInfo(model: SettingWithInfoOption(title: "Wi-Fi", icon: "wifi", iconBackgroundColor: "systemBlue", label: "Rem", handler: { print("Wi-fi tapped")})),
            .staticCellWithInfo(model: SettingWithInfoOption(title: "Bluetooth", icon: "bluetooth", iconBackgroundColor: "systemBlue", label: "Вкл.", handler: { print("Bluetooth tapped")})),
            .staticCell(model: SettingOption(title: "Сотовая связь", icon: "antenna.radiowaves.left.and.right", iconBackgroundColor: "systemGreen", handler: { print("Cellular tapped")})),
            .staticCell(model: SettingOption(title: "Режим модема", icon: "personalhotspot", iconBackgroundColor: "systemGreen", handler: { print("HotSpot tapped")})),
            .switchCell(model: SwitchSettingOption(title: "VPN", icon: "network.badge.shield.half.filled", iconBackground: "systemBlue", handler: { print("VPN is on")}, isOn: false)),
        ]))
        dataManager.models.append(Section(option: [
            .staticCell(model: SettingOption(title: "Уведомления", icon: "bell.badge.fill", iconBackgroundColor: "systemRed", handler: {
                print("Notification tapped")})),
            .staticCell(model: SettingOption(title: "Звуки, тактильные сигналы", icon: "speaker.wave.3.fill", iconBackgroundColor: "systemRed", handler: {
                print("Sounds tapped")})),
            .staticCell(model: SettingOption(title: "Фокусирование", icon: "powersleep", iconBackgroundColor: "systemIndigo", handler: {
                print("focus tapped")})),
            .staticCell(model: SettingOption(title: "Экранное время", icon: "hourglass", iconBackgroundColor: "systemIndigo", handler: {
                print("screen Time tapped")})),
        ]))

        dataManager.models.append(Section(option:[
            .staticCell(model: SettingOption(title: "Основные", icon: "gear", iconBackgroundColor: "systemGray") { print("general Time tapped")}),
            .staticCell(model: SettingOption(title: "Пункт управления", icon: "switch.2", iconBackgroundColor: "systemGray") {print("control center tapped") }),
            .staticCell(model: SettingOption(title: "Экран и яркость", icon: "sun.max", iconBackgroundColor: "systemBlue") { print("display tapped") }),
            .staticCell(model: SettingOption(title: "Экран \"Домой\" и библиотека приложений", icon: "square.grid.4x3.fill", iconBackgroundColor: "systemPurple") { print("AppGalery tapped")}),
            .staticCell(model: SettingOption(title: "Универсальный доступ", icon: "accessibility", iconBackgroundColor: "systemBlue") { print("Accessibility tapped") }),
            .staticCell(model: SettingOption(title: "Обои", icon: "atom", iconBackgroundColor: "systemCyan") { print("Wallpaper tapped")}),
        ]))
        dataManager.originalModels = dataManager.models
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
                let model = dataManager.models[indexPath.section].option[indexPath.row]
                switch model {
                    case .profileCell(_):
                        return 70
                    default:
                        return 44
                }
            }
            func numberOfSections(in tableView: UITableView) -> Int {
                dataManager.models.count
            }
            func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                return dataManager.models[section].option.count
            }

            func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                let model = dataManager.models[indexPath.section].option[indexPath.row]
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
                let type = dataManager.models[indexPath.section].option[indexPath.row]
                handleSelection(for: type)
            }

            func handleSelection(for option: SettingOptionType) {
                switch option {
                    case .staticCell(let model):
                        model.handler()
                    case .switchCell(let model):
                        model.handler()
                    case .staticCellWithInfo(let model):
                        model.handler()
                    case .profileCell(let model):
                        navigateToProfile(with: model)
                }
            }
            func navigateToProfile(with model: ProfileOption) {
                let profileVC = ProfileViewController()
                navigationController?.pushViewController(profileVC, animated: true)
            }

            func updateSearchResults(for searchController: UISearchController) {
                dataManager.filterForSearchText(searchController.searchBar.text ?? "")
                tableView.reloadData()
            }
        }
