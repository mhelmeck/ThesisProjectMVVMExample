//
//  ForecastViewModel.swift
//  ThesisProjectMVVMExample
//
//  Created by Maciej Hełmecki on 21/12/2018.
//  Copyright © 2018 Maciej Hełmecki. All rights reserved.
//

public struct ForecastViewModel {
    // MARK: - Properties
    public var iconName: String
    public var typeTextValue: String
    public var minTempTextValue: String
    public var maxTempTextValue: String
    public var windSpeedTextValue: String
    public var windDirectionTextValue: String
    public var rainfallTextValue: String
    public var pressureTextValue: String
    
    // MARK: - Init
    public init(iconName: String,
                typeTextValue: String,
                minTempTextValue: String,
                maxTempTextValue: String,
                windSpeedTextValue: String,
                windDirectionTextValue: String,
                rainfallTextValue: String,
                pressureTextValue: String) {
        self.iconName = iconName
        self.typeTextValue = typeTextValue
        self.minTempTextValue = minTempTextValue
        self.maxTempTextValue = maxTempTextValue
        self.windSpeedTextValue = windSpeedTextValue
        self.windDirectionTextValue = windSpeedTextValue
        self.rainfallTextValue = rainfallTextValue
        self.pressureTextValue = pressureTextValue
    }
}
