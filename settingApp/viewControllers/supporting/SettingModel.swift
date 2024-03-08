//
//  SettingModel.swift
//  settingApp
//
//  Created by Rustem on 03.03.2024.
//

import UIKit

struct Section {
//    let title: String
    let option: [SettingOptionType]
}
enum SettingOptionType {
    case profileCell(model:ProfileOption)
    case staticCell(model: SettingOption)
    case switchCell(model: SwitchSettingOption)
}

struct ProfileOption {
    let imageName: String
    let name: String
    let subName: String
    let handler: (() -> Void)
}

struct SettingOption {
    let title: String
    let icon: UIImage?
    let iconBackgroundColor: UIColor
    let handler: (() -> Void)
}

struct SwitchSettingOption {
    let title: String
    let icon: UIImage?
    let iconBackground: UIColor
    let handler: (() -> Void)
    var isOn: Bool
}
