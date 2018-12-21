//
//  MainTableCellViewModel.swift
//  ThesisProjectMVVMExample
//
//  Created by Maciej Hełmecki on 21/12/2018.
//  Copyright © 2018 Maciej Hełmecki. All rights reserved.
//

public struct MainTableCellViewModel {
    // ViewProperties
    public var cityName: String = ""
    public var temperature: String = ""
    public var iconName: String = ""
    
    // Init
    public init(cityName: String,
                temperature: String,
                iconName: String) {
        self.cityName = cityName
        self.temperature = temperature
        self.iconName = iconName
    }
}
