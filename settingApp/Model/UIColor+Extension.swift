//
//  UIColor+Extension.swift
//  settingApp
//
//  Created by Rustem on 25.03.2024.
//

import UIKit

extension UIColor {
    static func color(from string: String) -> UIColor {
        switch string {
            case "systemOrange":
                return .systemOrange
            case "systemBlue":
                return .systemBlue
            case "systemGreen":
                return .systemGreen
            case "systemRed":
                return .systemRed
            case "systemIndigo":
                return .systemIndigo
            case "systemGray":
                return .systemGray
            case "systemPurple":
                return .systemPurple
            case "systemCyan":
                return .systemCyan
            default:
                return .clear 
        }
    }
}
