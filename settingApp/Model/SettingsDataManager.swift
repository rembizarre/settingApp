//
//  SettingsDataManager.swift
//  settingApp
//
//  Created by Rustem on 25.03.2024.
//

import Foundation

class SettingsDataManager {
    var models = [Section]()
    //to store unfiltered data
    var originalModels = [Section]()

    init(models: [Section] = [Section](), originalModels: [Section] = [Section]()) {
        self.models = models
        self.originalModels = originalModels
    }

        func filterForSearchText(_ searchText: String) {
            if searchText.isEmpty {
                models = originalModels
            } else {
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
            }
        }
        func resetFilters() {
            models = originalModels
        }
    }

